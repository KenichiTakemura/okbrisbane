class MemberManagementsController < ApplicationController
  # GET /member_managements
  # GET /member_managements.json
  def index
    @member_managements = MemberManagement.all
    if params[:id]
      @selected = params[:id]
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @member_managements }
    end
  end

  def sign_in
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

  # GET /member_managements/1
  # GET /member_managements/1.json
  def show
    @member_management = MemberManagement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member_management }
    end
  end

  # GET /member_managements/new
  # GET /member_managements/new.json
  def new
    @member_management = MemberManagement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member_management }
    end
  end

  # GET /member_managements/1/edit
  def edit
    @member_management = MemberManagement.find(params[:id])
  end

  # POST /member_managements
  # POST /member_managements.json
  def create
    # @member_management = MemberManagement.new(params[:member_management])
# 
    # respond_to do |format|
      # if @member_management.save
        # format.html { redirect_to @member_management, notice: 'Member management was successfully created.' }
        # format.json { render json: @member_management, status: :created, location: @member_management }
      # else
        # format.html { render action: "new" }
        # format.json { render json: @member_management.errors, status: :unprocessable_entity }
      # end
    # end
    session[:agreed] = true
    redirect_to new_user_registration_path
  end

  # PUT /member_managements/1
  # PUT /member_managements/1.json
  def update
    @member_management = MemberManagement.find(params[:id])

    respond_to do |format|
      if @member_management.update_attributes(params[:member_management])
        format.html { redirect_to @member_management, notice: 'Member management was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_managements/1
  # DELETE /member_managements/1.json
  def destroy
    @member_management = MemberManagement.find(params[:id])
    @member_management.destroy

    respond_to do |format|
      format.html { redirect_to member_managements_url }
      format.json { head :no_content }
    end
  end

end
