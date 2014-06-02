class MobilesController < ApplicationController
    before_filter :find_mobile, :only => [:edit, :update,:destroy]
  def index
    @mobiles=current_user.mobiles
  end

  def new

  end

  def edit
    if @mobile.present?
      #render :json => { :mobile => @mobile, :status_code => "201" }
      else
      render :json => { :mobile => "Record not found", :status_code => "420" }
    end
  end

  def update
      if @mobile.present?
        @mobile.update_attributes(mobile_params)
        #~ @mobile.notify_user
      flash[:notice] = "Record updated successfully"
      redirect_to mobiles_path
    else
      flash[:alert] = "Record not found"
      redirect_to mobiles_path
    end
  end

  def create
    @mobile=current_user.mobiles.build(mobile_params)
    if @mobile.save
       #~ @mobile.notify_user
      render :json => { :mobile => @mobile, :status_code => "201" }
    else
      render :json => { :mobile => @mobile.errors, :status_code => "500" }
    end
  end

  def destroy
    if @mobile.present?
      @mobile.destroy
      flash[:notice] = "Record deleted successfully"
      redirect_to mobiles_path
    else
      flash[:alert] = "Record not found"
      redirect_to mobiles_path
    end
  end
end


private
def mobile_params
  params.require(:mobile).permit(:tag,:phone_no,:user_id,:status)
end

def find_mobile
    @mobile=Mobile.find_by_id(params[:id])
end