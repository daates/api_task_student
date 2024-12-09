require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school = School.create(name: "Test School", address: "123 Test St.")
    @school_class = @school.school_classes.create(number: 1, letter: "A", students_count: 0)
    @student = Student.create(first_name: "John", last_name: "Doe", surname: "Smith", school_id: @school.id, school_class_id: @school_class.id)
    @valid_attributes = {
      first_name: 'Alice',
      last_name: 'Wonderland',
      surname: 'Doe',
      school_id: @school.id,
      school_class_id: @school_class.id
    }
  end

  test 'should create student' do
    assert_difference '@school_class.reload.students_count', 1 do
      post students_url, params: { student: @valid_attributes }
    end
    assert_response :created
    assert_not_nil JSON.parse(response.body)["auth_token"]
    puts Student.last.auth_token

    student = Student.last
    assert_equal @valid_attributes[:first_name], student.first_name
    assert_equal @valid_attributes[:last_name], student.last_name
    assert_equal @valid_attributes[:school_id], student.school_id
    assert_equal @valid_attributes[:school_class_id], student.school_class_id
  end

  test "should destroy student and decrement students_count" do
    student2 = Student.create(first_name: "Sffrg", last_name: "Dffffoe", surname: "Sffffmith", school_id: @school.id, school_class_id: @school_class.id)
    student2.gen_token!
    puts student2.errors.full_messages
    token = student2.auth_token
    puts student2.inspect

    assert_difference '@school_class.reload.students_count', -1 do
      delete student_url(@student), headers: { 'Authorization' => "Bearer #{token}" }
    end

    assert_response :ok
    assert_match /Student successfully deleted/, response.body
  end
end
