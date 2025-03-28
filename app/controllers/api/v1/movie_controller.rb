class Api::V1::MovieController < ApplicationController
    def index
        if params[:search]
            # conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            #     faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:read_token]
            # end
    
            # response = conn.get("3/search/movie?query=#{params[:search]}")
            # json = JSON.parse(response.body,symbolize_names: true)
            search_results = MovieGateway.movie_search(params[:search])
            
            render json: MovieSerializer.format_movie_list(search_results)
        else
            render json: ErrorSerializer.format_error(ErrorMessage.new("A search is required for the movie endpoint", 400)), status: :bad_request
        end
    end

    def show
        render json: MovieSerializer.serialize_details(MovieGateway.fetch_movie_details(params[:id]))
    end
end