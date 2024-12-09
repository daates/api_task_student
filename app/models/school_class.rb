class SchoolClass < ApplicationRecord
  validates :number, :letter, :school_id, presence: true

  has_many :students
  belongs_to :school
end