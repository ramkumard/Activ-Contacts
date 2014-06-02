class FriendshipController < ApplicationController
    def index
        p @user_friends =Friendship.where(:user_id => current_user.id)
        p @mem= User.where("id != ?", current_user.id) 
        p @members=@mem-@user_friends
    end
end
