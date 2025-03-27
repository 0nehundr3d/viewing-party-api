class Api::V1::Movie::TopController < ApplicationController
    def index
        top_movies = MovieGateway.top_movies

        render json: MovieSerializer.format_movie_list(top_movies)
    end
end