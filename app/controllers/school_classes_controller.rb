class SchoolClassesController < ApplicationController
  # GET /schools/:school_id/school_classes
  def get_class_list
    begin
      @school = School.find(params[:school_id])
      @school_classes = @school.school_classes
      render json: { data: @school_classes }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "School not found" }, status: :not_found
    end
  end


  def get_class_students_list
    begin
      @school = School.find(params[:school_id])
      @school_class = @school.school_classes.find(params[:school_class_id])
      @students = @school_class.students
      render json: { data: @students }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "School or SchoolClass not found" }, status: :not_found
    end
  end
end

