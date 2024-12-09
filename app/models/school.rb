class School < ApplicationRecord
  validates :name, :address, presence: true
  has_many :students
  has_many :school_classes
end