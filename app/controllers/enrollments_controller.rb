class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [ :show ,:edit, :update, :destroy ]
  # skip_before_action :set_enrollment, only: [ :enrollmentrequest, :new]
  # GET /enrollments or /enrollments.json


  def index
    if current_user.has_role? :Student
      @enrollments = Enrollment.where(:studentid => current_user.id)
    elsif current_user.has_any_role? :Instructor, :Admin
      @enrollments = Enrollment.all
    else
      user_not_authorized
    end
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
    if ((current_user.has_any_role? :Student) && (current_user.id != @enrollment.studentid))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return
    end
  end


  # GET /enrollments/new
  def new
    if current_user.has_any_role? :Student
      @enrollment = Enrollment.new
      if @course.nil?
        @course = Course.find(params[:courseid])
      end
      user_list = User.where(:email => current_user.email).pluck(:id)
      user_list.each do |id|
        if id == current_user.id
        end
      end
    elsif current_user.has_any_role? :Instructor
      if (current_user.id != Course.find(params[:courseid]).user_id)
        user_not_authorized
      else
        @enrollment = Enrollment.new
        if @course.nil?
          @course = Course.find(params[:courseid])
        end
      end
    elsif current_user.has_any_role? :Admin
      @enrollment = Enrollment.new
      if @course.nil?
        @course = Course.find(params[:courseid])
      end
    else
      user_not_authorized
    end
  end

  # GET /enrollments/1/edit
  def edit
    if ((current_user.has_any_role? :Student) && (current_user.id != @enrollment.studentid))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return
    end
  end

  def drop
  end


  # POST /enrollments or /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.enrollmentstatus.nil?
      if @course.nil?
        @course = Course.find(@enrollment.courseid)
      end
      if @course.status == "CLOSED"
        flash[:notice] = "Enrollments to this Course is CLOSED"
        redirect_to courses_path
        return
      end
      if @course.capacity > Enrollment.where(:courseid => @enrollment.courseid, :enrollmentstatus => "ACCEPTED").count()
        @enrollment.enrollmentstatus = "ACCEPTED"
        if @course.capacity <= Enrollment.where(:courseid => @enrollment.courseid, :enrollmentstatus => "ACCEPTED").count()+1
          if @course.waitlistcapacity > Enrollment.where(:courseid => @enrollment.courseid, :enrollmentstatus => "WAITLIST").count()
            @course.status = "WAITLIST"
          else
            @course.status = "CLOSED"
          end
        end
      elsif @course.waitlistcapacity > Enrollment.where(:courseid => @enrollment.courseid, :enrollmentstatus => "WAITLIST").count()
        @enrollment.enrollmentstatus = "WAITLIST"
        if @course.waitlistcapacity <= Enrollment.where(:courseid => @enrollment.courseid, :enrollmentstatus => "WAITLIST").count()+1
          @course.status = "CLOSED"
        end
      end
      @course.save
    end
    if User.where(:id => @enrollment.studentid).count() > 0
      @user = User.find(@enrollment.studentid)
      if @user.has_any_role? :Student
        if Enrollment.where(:courseid => @enrollment.courseid, :studentid => @enrollment.studentid).count() == 0
          respond_to do |format|
            if @enrollment.save
              format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully created." }
              format.json { render :show, status: :created, location: @enrollment }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @enrollment.errors, status: :unprocessable_entity }
            end
          end
        else
          redirect_to new_enrollment_path
        end
      else
        redirect_to new_enrollment_path
      end
    else
      redirect_to new_enrollment_path
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    if ((current_user.has_any_role? :Student) && (current_user.id != @enrollment.studentid))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return
    else
      respond_to do |format|
        if @enrollment.update(enrollment_params)
          format.html { redirect_to enrollment_url(@enrollment), notice: "Enrollment was successfully updated." }
          format.json { render :show, status: :ok, location: @enrollment }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @enrollment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    if ((current_user.has_any_role? :Student) && (current_user.id != @enrollment.studentid))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return
    else
      tempcid = @enrollment.courseid
      tempid = @enrollment.id
      @enrollment.destroy
      respond_to do |format|
        format.html { redirect_to enrollments_url, notice: "Enrollment was successfully destroyed." }
        format.json { head :no_content }
      end
      @course = Course.find(@enrollment.courseid)
      Enrollment.where(:courseid => @enrollment.courseid).order(:created_at).limit(@course.capacity).update_all(enrollmentstatus: 'ACCEPTED')
      Enrollment.where(:courseid => @enrollment.courseid).where.not(:enrollmentstatus => 'ACCEPTED').order(:created_at).limit(@course.waitlistcapacity).update_all(enrollmentstatus: 'WAITLIST')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:studentid, :courseid, :enrollmentstatus)
    end
end
