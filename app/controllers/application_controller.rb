class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def opensearch
    @a =  '<?xml version="1.0" encoding="UTF-8"?> <OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/">   <ShortName>Web Search</ShortName>  <Description>127.0.0.1</Description>   <Tags>example web</Tags>   <Contact>admin@example.com</Contact>   <Url type="application/xml"        template="http://127.0.0.1/?q=cat&format=api"/> </OpenSearchDescription>'
@a = '<?xml version="1.0" encoding="UTF-8"?> <OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/"><ShortName>Merlin</ShortName><Description>Search my.merlin.net</Description><Tags>Merlin Search</Tags><Contact>support@merlinone.com</Contact><Url type="text/xml" template="http://mdemo2.merlinone.com:80/mweb/wmsql.wm.request?plugin_opensearch&amp;ali=XXC36E2C01F6F9BF0357D36013E883&amp;q=cat&amp;format=api"/><LongName>Merlin Search mdemo2.merlinone.com</LongName><Image height="64" width="64" type="image/png">http://mdemo2.merlinone.com:80/images/websearch64.png</Image><Image height="16" width="16" type="image/png">http://mdemo2.merlinone.com:80/images/websearch16.png</Image><Query role="example" searchTerms="test"/><Developer>MerlinOne Inc.</Developer><Attribution>Search engine MerlinOne </Attribution><SyndicationRight>open</SyndicationRight><AdultContent>false</AdultContent><Language>en-us</Language><OutputEncoding>UTF-8</OutputEncoding><InputEncoding>UTF-8</InputEncoding></OpenSearchDescription>'
    respond_to do |format|
    format.xml  { render :layout => false ,  :xml => @a }
    end
  end


    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end
  end
