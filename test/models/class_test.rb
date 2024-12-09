require 'test_helper'

class ClassTest < ActiveSupport::TestCase

  setup do
    @school = School.create(name: "Test School", address: "123 Test St.")
  end

  # Тест на создание класса с валидными аттрибутами
  test "should be valid with valid attributes" do
    school_class = @school.school_classes.create(number: 1, letter: 'A', students_count: 0)
    assert school_class.valid?
  end

  # Тест на создание класса без номера
  test "should be invalid without a number" do
    school_class = @school.school_classes.create(letter: 'A', students_count: 0)
    assert_not school_class.valid?
  end

  # Тест на создание класса без буквы
  test "should be invalid without a letter" do
    school_class = @school.school_classes.create(number: 1, students_count: 0)
    assert_not school_class.valid?
  end

  # Тест на создание класса без school_id
  test "should be invalid without a school_id" do
    school_class = SchoolClass.create(number: 1, letter: 'A', students_count: 0)
    assert_not school_class.valid?
  end

  # Тест на ассоциацию с школой
  test "should belong to a school" do
    school_class = @school.school_classes.create(number: 1, letter: 'A', students_count: 0)
    assert_equal @school, school_class.school
  end

  # Тест на ассоциацию с учениками
  test "should have many students" do
    school_class = @school.school_classes.create(number: 1, letter: 'A', students_count: 0)
    student = school_class.students.create(first_name: 'John', last_name: 'Doe', surname: 'Smith')

    assert_includes school_class.students, student
  end

  # Тест на логику подсчета студентов в классе
  test "should increment students_count when a student is added" do
    school_class = @school.school_classes.create(number: 1, letter: 'A')
    student = school_class.students.create(first_name: 'John', last_name: 'Doe', surname: 'Smith', school_id: @school.id)
    school_class.reload
    assert_equal 1, school_class.students_count
  end
end
