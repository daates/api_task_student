require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  setup do
    @school = School.create(name: "Test School", address: "123 Test St.")
    @school_class = @school.school_classes.create(number: 1, letter: "A", students_count: 0)
    valid_attributes = {
      first_name: 'Alice',
      last_name: 'Wonderland',
      surname: 'Doe',
      school_id: @school.id,
      school_class_id: @school_class.id
    }
  end

  # Тест на валидацию
  test "should not save student without first name" do
    student = Student.new(last_name: "Doe", surname: "Smith", school_id: 1, school_class_id: 1)
    assert_not student.save
  end

  test "should save student with valid params" do
    student = Student.new(first_name: "John", last_name: "Doe", surname: "Smith", school_id: @school.id, school_class_id: @school_class.id)
    puts student.errors.full_messages unless student.save
    assert student.save
  end

  test "should generate token" do
    student = Student.new(first_name: "John", last_name: "Doe", surname: "Smith", school_id: @school.id, school_class_id: @school_class.id)
    assert_nil student.auth_token
    student.gen_token!
    assert_not_nil student.auth_token
  end

  test "should validate token" do
    student = Student.create(first_name: "John", last_name: "Brown", surname: "Smith", school_id: @school.id, school_class_id: @school_class.id)
    student.gen_token!
    assert student.valid_token?
  end

  test "should invalidate token if expired" do
    student = Student.new(first_name: "John", last_name: "Doe", surname: "Smith", school_id: @school.id, school_class_id: @school_class.id)
    puts @school_class.students_count
    student.gen_token!
    expired_token = JWT.encode({ student_id: student.id, exp: 1.day.ago.to_i }, Student::SECRET_KEY, "HS256")
    student.update(auth_token: expired_token)
    assert_not student.valid_token?
  end

  test "should decode token" do
    student = Student.create(first_name: "John", last_name: "Doe", surname: "Smith", school_id: @school.id, school_class_id: @school_class.id)
    student.gen_token!
    decoded = Student.decode_token(student.auth_token)
    assert_equal student.id, decoded["student_id"]
  end
end
