class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,:omniauthable
  attr_accessor :login
  has_many :authentications
  has_many :mobiles
  has_many :user_friends
  has_many :user_friend_invites
  has_many :contacts
  has_many :contact_imports
  has_many :friendships, :foreign_key => "user_id", :dependent => :destroy
  has_many :user_albums, :foreign_key => "user_id", :dependent => :destroy
  has_many :user_photos, :foreign_key => "user_id", :dependent => :destroy
  def self.find_first_by_auth_conditions(warden_conditions) 
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end 
  
  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth, current_user)
    authorization = Authentication.where(:provider => auth.provider, :uid => auth.uid.to_s).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        user.username = auth.info.nickname
        user.email = auth.info.email
        auth.provider == "twitter" ?  user.save(:validate => false) :  user.save
      end
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end
 
end
