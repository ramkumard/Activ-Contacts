class Contact < ActiveRecord::Base
    has_one:address
    belongs_to :user
    validates_presence_of :name
end
