require "test_helper"

class ClassesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @school = School.create(name: 'Test School', address: '123 Test St.')
    @school_class = @school.school_classes.create(number: 1, letter: "A", students_count: 0)
    @school_class2 = @school.school_classes.create(number: 2, letter: "B", students_count: 0)
    @student = Student.create(
      first_name: "Alex",
      last_name: "Mar",
      surname: "Smash",
      school_id: @school.id,
      school_class_id: @school_class.id
    )

    @student2 = Student.create(
      first_name: "Sasha",
      last_name: "Map",
      surname: "rock",
      school_id: @school.id,
      school_class_id: @school_class.id
    )
    puts @student2.errors.full_messages
  end

  test "should get class list for a school" do
    get school_classes_url(@school)
    assert_response :success

    response_data = JSON.parse(response.body)

    assert_equal 2, response_data["data"].size
    assert_equal @school_class.number, response_data["data"][0]["number"]
    assert_equal @school_class.letter, response_data["data"][0]["letter"]
  end

  test "should get students list for a school class" do
    get school_class_students_url(@school, @school_class)
    assert_response :success


    response_data = JSON.parse(response.body)

    assert_equal 1, response_data.size
    assert_equal @student.first_name, response_data["data"][0]["first_name"]
    assert_equal @student.last_name, response_data["data"][0]["last_name"]
  end

end


