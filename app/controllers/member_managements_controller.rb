class MemberManagementsController < OkController

  before_filter :page_p_signup, :only => ["sign_up","term","personal","create","inactive_signup"]
  before_filter :page_p_signin, :only => ["sing_in","sending_reset_password_instructions","after_reset_password","after_confirmation"]
  def page_p_signup
    @okpage = :p_signup
  end

  def page_p_signin
    @okpage = :p_signin
  end

  def sign_in
    session[:signin_menu] = :singin
    redirect_to new_user_session_path
  end

  def sign_out
    @okpage = :p_signout
    respond_to do |format|
      format.html # sign_out.html.erb
    end
  end

  def sign_up
    @member_management = MemberManagement.new
    respond_to do |format|
      format.html # sign_up.html.erb
      format.json { render :json => @member_management }
    end
  end

  def inactive_signup
    @email = params[:email]
    respond_to do |format|
      format.html
    end
  end

  def sending_reset_password_instructions
    @email = params[:email]
    respond_to do |format|
      format.html { render :template => "member_managements/reset_password" }
      format.json { render :json => @email }
    end
  end
  
  def after_reset_password 
    respond_to do |format|
      format.html
    end
  end
  
  def after_confirmation
    respond_to do |format|
      format.html
    end
  end
  
  def term
    respond_to do |format|
      format.html # term.html.erb
    end
  end

  def personal
    respond_to do |format|
      format.html # personal.html.erb
    end
  end

  def create
    session[:agreed] = true
    redirect_to new_user_registration_path
  end

end
