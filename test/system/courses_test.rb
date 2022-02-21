require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:one)
  end

  test "visiting the index" do
    visit courses_url
    assert_selector "h1", text: "Courses"
  end

  test "should create course" do
    visit courses_url
    click_on "New course"

    fill_in "Capacity", with: @course.capacity
    fill_in "Coursecode", with: @course.coursecode
    fill_in "Description", with: @course.description
    fill_in "Endtime", with: @course.endtime
    fill_in "Instructorname", with: @course.instructorName
    fill_in "Name", with: @course.name
    fill_in "Room", with: @course.room
    fill_in "Starttime", with: @course.starttime
    fill_in "Status", with: @course.status
    fill_in "User", with: @course.user_id
    fill_in "Waitlistcapacity", with: @course.waitlistcapacity
    fill_in "Weekdayone", with: @course.weekdayone
    fill_in "Weekdaytwo", with: @course.weekdaytwo
    click_on "Create Course"

    assert_text "Course was successfully created"
    click_on "Back"
  end

  test "should update Course" do
    visit course_url(@course)
    click_on "Edit this course", match: :first

    fill_in "Capacity", with: @course.capacity
    fill_in "Coursecode", with: @course.coursecode
    fill_in "Description", with: @course.description
    fill_in "Endtime", with: @course.endtime
    fill_in "Instructorname", with: @course.instructorName
    fill_in "Name", with: @course.name
    fill_in "Room", with: @course.room
    fill_in "Starttime", with: @course.starttime
    fill_in "Status", with: @course.status
    fill_in "User", with: @course.user_id
    fill_in "Waitlistcapacity", with: @course.waitlistcapacity
    fill_in "Weekdayone", with: @course.weekdayone
    fill_in "Weekdaytwo", with: @course.weekdaytwo
    click_on "Update Course"

    assert_text "Course was successfully updated"
    click_on "Back"
  end

  test "should destroy Course" do
    visit course_url(@course)
    click_on "Destroy this course", match: :first

    assert_text "Course was successfully destroyed"
  end
end
