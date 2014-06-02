class ContactImportsController < ApplicationController

  def index
    @contacts=Contact.where(:user_id =>current_user.id)
  end

  def new

  end

  def create
    @contact_import = ContactImport.new(contact_import_params)
    respond_to do |format|
      if @contact_import.valid? && @contact_import.save
        file_name=@contact_import.document.url
        delyed_job = Delayed::Job.enqueue(CallSchedulerJob.new(file_name,@contact_import.id,current_user.id))
        format.html { redirect_to contact_imports_path}
        format.json {render :json => { "status_code" => "200", :contact_import => @contact_import }}
      else
        format.html {render action:'new'}
        format.json{render :json => { "status_code" => "400", :contact_import => @contact_import.errors }}
      end
		end
  end

  private

  def contact_import_params
    params.require(:contact_import).permit(:user_id,:document)
  end
end
