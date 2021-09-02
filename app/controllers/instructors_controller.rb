class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_message
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_message

    #GET to /instructors
    def index
        instructors = Instructor.all
        render json: instructors
    end

    #GET to /instructors/:id
    def show
        instructor = find_instructor
        render json: instructor
    end

    #POST to /instructors
    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    #PATCH to /instructors/:id
    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor
    end

    #DELETE to /instructors/:id
    def destroy
        instructor = find_instructor
        instructor.destroy
        head :no_content
    end

    private

    #Helper method to find instructor by ID
    def find_instructor
        Instructor.find(params[:id])
    end

    #Params method
    def instructor_params
        params.permit(:name)
    end

    #Render error message when instructor not found in db
    def render_record_not_found_message
        render json: {error: "Instructor not found"}, status: :not_found
    end

    #Render error message when entry doesn't pass data validation
    def render_invalid_record_message(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
