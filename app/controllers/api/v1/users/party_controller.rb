class Api::V1::Users::PartyController < ApplicationController
    def create
        viewing_party = ViewingParty.create!(viewing_party_params)
        viewing_party.invite_users(params[:invitees])

        render json: ViewingPartySerializer.serialize(viewing_party), status: 201
    end

    private

    def viewing_party_params
        params.permit(:name, :start_time, :end_time, :movie_id, :movie_title)
    end
end