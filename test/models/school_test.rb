require 'test_helper'

class SchoolTest < ActiveSupport::TestCase

  setup do
    @school = School.create(name: "Greenwich High School", address: "123 Main St.")
  end

  test 'should be valid with valid attributes' do
    school = School.new(name: 'New School', address: '789 New St')
    assert school.valid?
  end

  test 'should not be valid without name' do
    school = School.new(@school.attributes.except('name'))
    assert_not school.valid?
    assert_includes school.errors[:name], "can't be blank"
  end

  test 'should not be valid without address' do
    school = School.new(@school.attributes.except('address'))
    assert_not school.valid?
    assert_includes school.errors[:address], "can't be blank"
  end
end
