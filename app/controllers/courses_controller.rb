class CoursesController < ApplicationController
  before_action :update_courses_table
  before_action :set_course, only: %i[ show edit update destroy]
  # before_action :correct_user, only: [ :show, :edit, :update, :destroy ]



  attr_reader :courseid
  helper_method :enrollmentrequest
  def enrollmentrequest(courseid)
      @enrollment = Enrollment.new
      @enrollment.studentid = current_user.id
      @enrollment.courseid = courseid
      @enrollment.enrollmentstatus = "ACCEPTED"
      if @enrollment.save
        flash[:notice]="Enrollment Requested"
        # redirect_to(courses_path)
      else
        flash[:notice]="Enrollment has already been Requested"
        # redirect_to(courses_path)
      end
      #end
  end

  def update_courses_table
    @courses = Course.all
    for @course in @courses do 
      if @course.capacity > Enrollment.where(:courseid => @course.id , :enrollmentstatus => "ACCEPTED").count()
        @course.status = "OPEN"
      elsif @course.waitlistcapacity > Enrollment.where(:courseid => @course.id , :enrollmentstatus => "WAITLIST").count()
        @course.status = "WAITLIST"
      else
        @course.status = "CLOSED"
      end
      @course.save
    end
  end
  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end 

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    if current_user.has_any_role? :Admin, :Instructor
      @course = Course.new
    else
      user_not_authorized
    end
  end

  # GET /courses/1/edit
  def edit
    if ((current_user.has_any_role? :Instructor) && (current_user.id != @course.user_id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return
    end
    if current_user.has_role? :Student
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return
    end
  end


  # POST /courses or /courses.json
  def create
    if current_user.has_role? :Student
      user_not_authorized
    else
      @course = Course.new(course_params)
      if ((@course.capacity > 0) && (@course.waitlistcapacity>=0))
        @course.status = "OPEN"
      elsif (@course.capacity == 0) && (@course.waitlistcapacity>0)
        @course.status = "WAITLIST"
      else
        @course.status = "CLOSED"
      end
      if (current_user.has_role? :Instructor)
        @course.instructorName = current_user.name
      end
      respond_to do |format|
        if @course.save
          format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
          format.json { render :show, status: :created, location: @course }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if ((current_user.has_any_role? :Instructor) && (current_user.id != @course.user_id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return
    end
    if current_user.has_role? :Student
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return 
    else
      respond_to do |format|
        if @course.update(course_params)
          format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
          format.json { render :show, status: :ok, location: @course }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def check_enrollment(course_id, student_id)
    if Enrollment.where(:courseid => course_id, :studentid => student_id).exists?
      return false
    else
      return true
    end
  end

  def delete_enrollment()
    params[:course_id]
    if Enrollment.where(:courseid => params[:courseid], :studentid => params[:studentid]).exists?
      Enrollment.where(:courseid => params[:courseid], :studentid => params[:studentid]).destroy_all
    end
    redirect_back(fallback_location: courses_path)
  end

  def delete_course()
    if ((current_user.has_any_role? :Instructor) && (current_user.id != @course.user_id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path)
      return
    end
    if current_user.has_role? :Student
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return 
    end
    if Course.where(:id => params[:courseid]).exists?
      Course.where(:id => params[:courseid]).destroy_all
      Enrollment.where(:courseid => params[:courseid]).destroy_all
    end
    redirect_back(fallback_location: courses_path)
  end

  
  # DELETE /courses/1 or /courses/1.json
  def destroy
    if ((current_user.has_any_role? :Instructor) && (current_user.id != @course.user_id))
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return
    end
    if current_user.has_role? :Student
      flash[:notice] = "You are not authorized to perform this action."
      redirect_to( courses_path )
      return 
    end
    if current_user.has_role? :Student
      user_not_authorized
      return
    else
      @course.destroy
      respond_to do |format|
        format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
      if @course.capacity > Enrollment.where(:courseid => @course.id , :enrollmentstatus => "ACCEPTED").count()
        @course.status = "OPEN"
      elsif @course.waitlistcapacity > Enrollment.where(:courseid => @course.id , :enrollmentstatus => "WAITLIST").count()
        @course.status = "WAITLIST"
      else
        @course.status = "CLOSED"
      end
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :description, :user_id, :instructorName, :weekdayone, :weekdaytwo, :starttime, :endtime, :coursecode, :capacity, :waitlistcapacity, :status, :room)
    end

    helper_method :check_enrollment
    helper_method :delete_enrollment
    helper_method :delete_course
end
