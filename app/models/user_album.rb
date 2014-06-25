class UserAlbum < ActiveRecord::Base
    belongs_to :users
	has_many :user_photos, :foreign_key => "user_album_id", :dependent => :destroy
	accepts_nested_attributes_for :user_photos, :allow_destroy => true
    has_attached_file :photo,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {},
    :path => '/user/:id/:basename.:extension'
    do_not_validate_attachment_file_type :photo
end
