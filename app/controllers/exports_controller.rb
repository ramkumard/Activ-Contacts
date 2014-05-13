require 'vpim/vcard'
class ExportsController < ApplicationController
  def create
    @user = Employee.find_by_id(params[:id])
    card = Vpim::Vcard::Maker.make2 do |maker|
      maker.add_name do |name|
        name.prefix = ''
        name.given = @user.fname
        name.family = @user.lname
      end

      maker.add_addr do |addr|
        addr.preferred = true
        addr.location = 'work'
        addr.street = '243 Felixstowe Road'
        addr.locality = 'Ipswich'
        addr.country = 'United Kingdom'
      end
      maker.add_tel(@user.telephone)
      maker.add_email(@user.email) { |e| e.location = 'work' }
    end
    send_data card.to_s, :filename => "contact.vcf"
  end

end
