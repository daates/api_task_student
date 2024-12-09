class Student < ApplicationRecord
  validates :first_name, :last_name, :surname, :school_id, :school_class_id, presence: true
  validates :auth_token, uniqueness: true

  belongs_to :school_class
  belongs_to :school

  after_create :increment_students_count
  after_destroy :decrement_students_count

  SECRET_KEY = Rails.application.credentials[:secret_key]

  def gen_token!
    payload = {
      student_id: self.id,
      exp: 1.day.from_now.to_i
    }
    self.auth_token = JWT.encode(payload, SECRET_KEY, "HS256")
    save!
  end

  def self.decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256", verify_exp: true })
    decoded.first
  rescue JWT::ExpiredSignature
    nil
  rescue JWT::DecodeError
    nil
  end

  def valid_token?
    payload = self.class.decode_token(auth_token)
    payload && payload["student_id"] == self.id
  end

  def increment_students_count
    school_class.increment!(:students_count)
  end

  def decrement_students_count
    school_class.decrement!(:students_count)
  end
end
