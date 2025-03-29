class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

    private

    def not_found_response(exception)
        # binding.pry
        render json: ErrorSerializer.format_error(ErrorMessage.new("Could not find #{exception.model} with id #{exception.id}", 404)), status: :not_found
    end
end
