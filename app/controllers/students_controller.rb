class StudentsController < ApplicationController
  before_action :authenticate_with_token!, only: [ :destroy ]

  def create
    @student = Student.find_or_initialize_by(
      first_name: student_params[:first_name],
      last_name: student_params[:last_name],
      surname: student_params[:surname],
      school_id: student_params[:school_id],
      school_class_id: student_params[:school_class_id]
    )

    @student.gen_token!

    if @student.save
      render json: @student, status: :created, headers: { 'X-Auth-Token': @student.auth_token }
    else
      render json: { errors: @student.errors.full_messages }, status: :unprocessable_content
    end
  end


 

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :surname, :school_id, :school_class_id)
  end

  def authenticate_with_token!
    token = request.headers["Authorization"]&.split(" ")&.last

    if token.nil?
      render json: { error: "Unauthorized" }, status: :unauthorized and return
    end

    decoded_token = Student.decode_token(token)

    if decoded_token.nil?
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end

