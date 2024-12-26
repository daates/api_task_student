class StudentsController < ApplicationController
  before_action :authenticate_with_token!, only: [ :destroy ]

  


  def destroy
    @student = Student.find(params[:id])

    if @student
      if @student.destroy
        render json: { message: "Student successfully deleted" }, status: :ok
      else
        render json: { error: "Failed to delete student" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Student not found" }, status: :not_found
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

