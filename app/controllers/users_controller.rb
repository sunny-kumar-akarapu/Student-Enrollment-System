class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :newInstructor]
  before_action :set_user, only: %i[ show edit update destroy editAdmin editInstructor ]

  # GET /users or /users.json
  def index
    if current_user.has_any_role? :Admin, :Instructor
      @users = User.all
    else
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return
    end
  end

  # GET /users/1 or /users/1.json
  def show
    if ((current_user.has_any_role? :Student,:Instructor) && (current_user.id != @user.id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return
    end
  end

  def showAdmin
    if current_user.has_any_role? :Student,:Instructor 
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return
    end
  end

  def showinstructor
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def newInstructor
    @user = User.new

  end

  # GET /users/1/edit
  def edit
    if ((current_user.has_any_role? :Student,:Instructor) && (current_user.id != @user.id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return
    elsif (@user.has_any_role? :Admin)
      flash[:notice] = "Admin details cannot be changed."
      redirect_to( users_path )
      return
    end
  end 

  def editInstructor
    if ((current_user.has_any_role? :Student,:Admin,:Instructor) && (current_user.id != @user.id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return
    end
  end
  def editAdmin
    if ((current_user.has_any_role? :Admin) && (current_user.id != @user.id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.has_role? :Admin
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return 
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if current_user.has_any_role? :Student
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return
    end
    if (@user.has_role? :Admin) 
      if(current_user.has_any_role? :Student,:Instructor) 
        user_not_authorized
        return
      end
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /users/1 or /users/1.json
  def destroy
    if ((current_user.has_any_role? :Student,:Instructor) && (current_user.id != @user.id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( users_path )
      return
    elsif (current_user.has_any_role? :Admin) && (current_user.id == @user.id)
      flash[:notice] = "You cant delete your own account."
      redirect_to( users_path )
      return
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to signupinstructor_url, :flash => { :notice => "Record not found." }
        return
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :department, :number, :dob, :major, {role_ids: []})
    end
end
