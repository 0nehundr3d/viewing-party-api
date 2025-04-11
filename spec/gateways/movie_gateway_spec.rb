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
        it "should return a movies runtime", :vcr do
            expect(MovieGateway.fetch_movie_runtime(278)).to eq(142)
        end
    end

    describe "#fetch_movie_details" do
        it "should return details of a movie", :vcr do
            movie = MovieGateway.fetch_movie_details(278)

            expect(movie).to be_a(Movie)
            expect(movie.title).to eq("The Shawshank Redemption")
            expect(movie.release_year).to eq(1994)
            expect(movie.vote_average).to eq(8.708)
            expect(movie.runtime).to eq("2 hours, 22 minutes")
            expect(movie.genres).to eq(["Drama", "Crime"])
            expect(movie.summary).to eq("Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
            expect(movie.cast.count).to be <= 10
            expect(movie.total_reviews).to eq(17)
            expect(movie.reviews.count).to be <= 5
        end
    end
end