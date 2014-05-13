class ContactImport < ActiveRecord::Base
  belongs_to :user
  has_attached_file :document,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {},
    :path => '/contacts/:id/:basename.:extension'
  do_not_validate_attachment_file_type :document

  def self.upload_contacts(file_name,contact_imports_id,user_id,job)
    delay=StatusInfo.find_by_contact_imports_id(contact_imports_id)
    cards = Vpim::Vcard.decode(open(file_name))
    delay.update_attributes(:status => '300' ,:status_desc => 'File decryption completed',:delayed_desc =>job.last_error)
    cards.each_with_index do |card,index|
    @phones=[]
    @full_name,@last_name,@first_name,@email,@organisation,@bday,@note=""
    count=(680/cards.count-index)
    delay.update_attributes(:status => count ,:status_desc => 'Contacts Upload In Progress....',:delayed_desc =>job.last_error)
      card.each do |line|
        case line.name
        when 'FN'
          @full_name = line.value
        when 'N'
          _temp = line.value.split(';')
          @last_name = _temp.reverse!.pop
          @first_name = _temp.reverse!.join(' ')
        when 'CN'
          _temp = line.value.split(' ')
          @last_name = _temp.reverse!.pop
          @first_name = _temp.reverse!.join(' ')
        when 'FIRSTNAME'
          @first_name = line.value
        when 'LASTNAME'
          @last_name = line.value
        when 'EMAIL', 'MAIL', 'mail'
          @email = line.value
        when 'ORG', 'COMPANY'
          @organisation = line.value
        when 'TEL', 'TELEPHONENUMBER'
          @phones << line.value
        when 'bday', 'BDAY'
          @bday = line.value
        when 'note', 'NOTE'
          @note = line.value
        else
          Rails.logger.info "Currently Not Required Field #{line.name} - #{line.value}"
        end
      end
        user_response = Hash.new
        user_response[:contacts] = Hash.new
        user_response[:contacts][:name]= @full_name ? @full_name.gsub(/[^0-9A-Za-z\s]/, '') : @last_name.gsub(/[^0-9A-Za-z\s]/, '')
        user_response[:contacts][:email]= @email ? @email : ""
        user_response[:contacts][:organisation]= @organisation ? @organisation : ""
        user_response[:contacts][:phones]= @phones ? @phones : []
        user_response[:contacts][:dob]= @bday ? @bday : ""
        user_response[:contacts][:note]= @note ? @note : ""
        if user_response[:contacts][:name].present? && user_response[:contacts][:phones].present?
            Contact.create!(:name => user_response[:contacts][:name],:email =>user_response[:contacts][:email],:organisation =>user_response[:contacts][:organisation],:phones => user_response[:contacts][:phones],:dob => user_response[:contacts][:dob],:note => user_response[:contacts][:note] )
        end
    end
    delay.update_attributes(:status => "1000" ,:status_desc => 'Contacts Uploaded Successfully',:delayed_desc =>job.last_error)
  end
end

