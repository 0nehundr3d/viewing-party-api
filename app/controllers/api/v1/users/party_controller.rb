class Api::V1::Users::PartyController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

    def create
        invalid_params = ViewingParty.validate_params(params)
        if !invalid_params.empty?
            return render json: ErrorSerializer.format_error(ErrorMessage.new("Missing required params #{invalid_params.join(", ")} for creating viewing party", 400)), status: 400
        end

        party_duration = Time.parse(params[:end_time]) - Time.parse(params[:start_time])
        if party_duration < 0
            return render json: ErrorSerializer.format_error(ErrorMessage.new("Can not create a viewing party with and end time before its begin time", 400)), status: 400
        end

        movie_duration = MovieGateway.fetch_movie_runtime(params[:movie_id])
        if (party_duration / 60) < movie_duration
            return render json: ErrorSerializer.format_error(ErrorMessage.new("Can not create a viewing party with less duration than the movie being viewed (#{movie_duration} minutes)", 400)), status: 400
        end

        viewing_party = ViewingParty.create!(viewing_party_params)
        viewing_party.invite_users(params[:invitees], params[:user_id])

        render json: ViewingPartySerializer.serialize(viewing_party), status: 201
    end

    def update
        party = ViewingParty.find(params[:id])
        party.invite_users([params[:invitees_user_id]], params[:user_id])
        render json: ViewingPartySerializer.serialize(party)
    end

    private

    def viewing_party_params
        params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
    end

    def not_found_response(exception)
        # binding.pry
        render json: ErrorSerializer.format_error(ErrorMessage.new("Could not find #{exception.model} with id #{exception.id}", 404)), status: :not_found
    end
end