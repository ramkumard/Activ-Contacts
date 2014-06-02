class AddressesController < ApplicationController
  require 'will_paginate/array'
  before_filter :load_contact, :except => [:new, :create, :edit]

  def index
    @contact=Contact.where(:user_id=>current_user.id).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @contact = Contact.new
    @address = Address.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.phones=contact_params['phones'].split(",")
    @address = Address.new(address_params)
    respond_to do |format|
      if @contact.valid? && @address.valid?
        @contact.save &&  @address.save
        @address.update_attributes(:contact_id => @contact.id)
        format.html { redirect_to addresses_path}
        format.json {render :json => { "status_code" => "200", :contact => @contact ,:address =>@address }}
      else
        @contact.errors.add(:base, 'Please specify a valid address') unless @address.valid?
        format.html {render action:'new'}
        format.json{render :json => { "status_code" => "400", :contact => @contact.errors}}
      end
    end
  end

  def edit
    @address=Address.find_by_id(params[:id])
    @contact=@address.contact
  end

  def update
    @address=Address.find_by_id(params[:id])
    respond_to do |format|
      if @address.contact.update_attributes(contact_params) && @address.update_attributes(address_params)
        @address.contact.update_attributes(:phones => contact_params['phones'].split(","))
        format.html { redirect_to addresses_path}
        format.json {render :json => { "status_code" => "200", :contact => @contact ,:address =>@address }}
      else
        @contact.errors.add(:base, 'Please specify a valid address') unless @address.valid?
        format.html {render action:'edit'}
        format.json{render :json => { "status_code" => "400", :contact => @contact.errors}}
      end
    end
  end


  def destroy
    @address=Address.find_by_id(params[:id])
    respond_to do |format|
      if @address.contact.destroy && @address.destroy
        format.html { redirect_to addresses_path}
        format.json {render :json => { "status_code" => "200"}}
      else
        format.html {redirect_to addresses_path}
        format.json{render :json => { "status_code" => "400"}}
      end
    end
  end


  def search
    @contact=Contact.where("name ILIKE '%#{params[:search]}%'").paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.js
    end
end

  def alphabetical
    @contact=Contact.where("name ILIKE '#{params[:search]}%'").paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.js
    end
  end

  private

  def load_contact
    @contact = Contact.find_by_id(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name,:phones, :dob, :email, :organisation, :user_id)
  end


  def address_params
    params.require(:address).permit(:address1, :address2, :city, :state, :zip,:contact_id)
  end
end
