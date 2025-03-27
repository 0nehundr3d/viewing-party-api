require "rails_helper"

RSpec.describe MovieGateway do
    describe "#movie_search" do
        it "should fetch 20 relevent movies from search query", :vcr do
            movies = MovieGateway.movie_search("Fast")

            expect(movies).to be_an Array
            expect(movies.length).to eq(20)
            expect(movies.first).to be_instance_of(Movie)
        end
    end

    describe "#top_movies" do
        it "Should fetch the top 20 highest rated movies", :vcr do
            movies = MovieGateway.top_movies

            expect(movies).to be_an Array
            expect(movies.length).to eq(20)
            expect(movies.first).to be_instance_of(Movie)
        end
    end

    describe "#fetch_movie_runtime" do
        it "should return a movies runtime" do
            expect(MovieGateway.fetch_movie_runtime(278)).to eq(142)
        end
    end
end