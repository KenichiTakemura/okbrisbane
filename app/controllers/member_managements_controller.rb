class MemberManagementsController < ApplicationController

  def sign_in
    session[:signin_menu] = :singin
    redirect_to new_user_session_path
  end

  def sign_up
    @member_management = MemberManagement.new
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

  # POST /member_managements
  # POST /member_managements.json
  def create
    session[:agreed] = true
    redirect_to new_user_registration_path
  end

 
end
