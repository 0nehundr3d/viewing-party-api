class Api::V1::MovieController < ApplicationController
    def index
        if params[:search]
            conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
                faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:read_token]
            end
    
            response = conn.get("3/search/movie?query=#{params[:search]}")
            json = JSON.parse(response.body,symbolize_names: true)
    
            render json: MovieSerializer.format_movie_list(json[:results])
        else
            render json: ErrorSerializer.format_error(ErrorMessage.new("A search is required for the movie endpoint", 400)), status: :bad_request
        end
    end
end