class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_message
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_message

    # GET to /students
    def index
        students = Student.all
        render json: students
    end

    # GET to /students/:id
    def show
        student = find_student
        render json: student
    end

    #POST to /students
    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    #PATCH to /students/:id
    def update
        student = find_student
        student.update!(student_params)
        render json: student
    end

    #DELETE to /students/:id
    def destroy
        student = find_student
        student.destroy
        head :no_content
    end

    private
    #Helper method to find student by ID
    def find_student
        Student.find(params[:id])
    end

    #Params method
    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    #Render error message when student not found in db
    def render_record_not_found_message
        render json: {error: "Student not found"}, status: :not_found
    end

    #Render error message when entry doesn't pass data validation
    def render_invalid_record_message(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
