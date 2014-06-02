class Mobile < ActiveRecord::Base
    belongs_to :user
    validates :phone_no, :presence => {:message =>"Please enter mobile no"}
    
    
 def notify_user
      if self.notify_user==true
          vcard=self.create_vcard
      end
 end


def create_vcard
  card = Vpim::Vcard::Maker.make2 do |maker|
      maker.add_name do |name|
        name.prefix = ''
        name.given = self.user ? self.user.username : ""
      end
      maker.add_tel(self.phone_no)
      maker.add_email((self.user.email) )
  end
  return card.to_s
    #~ send_data card.to_s, :filename => "contact.vcf"
end
end
