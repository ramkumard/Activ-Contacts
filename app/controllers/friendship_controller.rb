class FriendshipController < ApplicationController
    def index
         @user_friends=Friendship.where('(user_id= ?) OR (friend_id= ?) and approved =? and status=?', current_user.id, current_user.id,"true","true")
         @friends=Friendship.where('(user_id= ?) OR (friend_id= ?)', current_user.id, current_user.id).pluck(:user_id,:friend_id).uniq.flatten
         @members=  @friends==[] ? User.where("id!=?",current_user.id) : User.where("id NOT IN (?)",@friends)
    end
    
    def new
         @friends=Friendship.create(:user_id=>current_user.id , :friend_id =>params[:friend_id] ,:approved =>"false")
         @user_friends=Friendship.where('(user_id= ?) OR (friend_id= ?) and approved =? and status=?', current_user.id, current_user.id,"true","true")
         @friends=Friendship.where('(user_id= ?) OR (friend_id= ?)', current_user.id, current_user.id).pluck(:user_id,:friend_id).uniq.flatten
         @members=  @friends==[] ? User.where("id!=?",current_user.id) : User.where("id NOT IN (?)",@friends)
    respond_to do |format|
      format.js
    end
    end
end
