class Api::V1::Movie::TopController < ApplicationController
    def index
        conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:read_token]
        end

        response = conn.get("/3/movie/top_rated")
        json = JSON.parse(response.body, symbolize_names: true)

        render json: MovieSerializer.format_movie_list(json[:results])
    end
end