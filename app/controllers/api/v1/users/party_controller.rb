class Api::V1::Users::PartyController < ApplicationController
    def create
        invalid_params = ViewingParty.validate_params(params)
        if !invalid_params.empty?
            return render json: ErrorSerializer.format_error(ErrorMessage.new("Missing required params #{invalid_params.join(", ")} for creating viewing party", 400)), status: 400
        end
        viewing_party = ViewingParty.create!(viewing_party_params)
        viewing_party.invite_users(params[:invitees], params[:user_id])
        render json: ViewingPartySerializer.serialize(viewing_party), status: 201
    end

    private

    def viewing_party_params
        params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
    end
end