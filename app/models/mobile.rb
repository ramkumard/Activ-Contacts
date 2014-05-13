class Mobile < ActiveRecord::Base
    belongs_to :user
    validates :phone_no, :presence => {:message =>"Please enter mobile no"}
end
