class MemberManagementsController < ApplicationController

  def sign_in
    session[:signin_menu] = :singin
    @okpage = Style::PAGES[:p_signin]
    redirect_to new_user_session_path(:okpage => @okpage)
  end

  def sign_up
    @member_management = MemberManagement.new
    @okpage = Style::PAGES[:p_signup]
    respond_to do |format|
      format.html # sign_up.html.erb
      format.json { render json: @member_management }
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
