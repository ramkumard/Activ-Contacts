class Address < ActiveRecord::Base
     belongs_to:contact
     validates_presence_of :address1, :address2, :city, :state, :zip
end
