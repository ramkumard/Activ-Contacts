class UserFriendInvitesController < ApplicationController
    
 before_filter :find_friend, :except => [:new]
 before_filter :list_friends
  def new
  end


 def accept
    @friend.update_attributes(:approved =>"true",:status =>"true")
     respond_to do |format|
      format.js
    end
 end
 
 def reject
    @friend.update_attributes(:approved =>"false",:status =>"false")
    respond_to do |format|
      format.js
    end
 end
 
 private
 
 def find_friend
   @friend=Friendship.find(params[:id]) 
end

def list_friends
    @friends=Friendship.where(:friend_id=>current_user.id,:approved =>"false",:status=>nil)
end

end
