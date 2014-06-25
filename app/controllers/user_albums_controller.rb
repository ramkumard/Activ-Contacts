class UserAlbumsController < ApplicationController
    
    # index
	def index
		@user_albums = UserAlbum.find_all_by_user_id(params[:id])
		
	end
	
	def show
		@user_album = UserAlbum.find(params[:id])
		@user_photos = @user_album.user_photos
	end
	
	def new
		@user_album = UserAlbum.new
		5.times {@user_album.user_photos.build}
	end
	
	def create
		@user_album = UserAlbum.new(user_album_params)
		@user_album.user_id = current_user.id
		
		if @user_album.save
			UserPhoto.destroy_all(["user_id = ? AND photo is null", @user.id])
			redirect_to "/users/albums/#{@user.id}", :flash => { :success => "You successfully added photos." }
		else
			redirect_to "/users/albums/#{@user.id}", :flash => { :error => "There was a problem adding photos." }
		end
		
	end
    
   private
def user_album_params
  params.require(:user_album).permit(:name,user_photos_attributes: [:title, :photo, :user_id])
end

end
