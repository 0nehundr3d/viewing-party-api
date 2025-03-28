require "rails_helper"

RSpec.describe Movie do
    describe "#initialize" do
        it "Should be able to create a movie object from a hash" do
            movie_data = JSON.parse(File.read("spec/fixtures/movie/movie.json"), symbolize_names: true)
            .merge(JSON.parse(File.read("spec/fixtures/movie/cast.json"), symbolize_names: true))
            .merge(JSON.parse(File.read("spec/fixtures/movie/reviews.json"), symbolize_names: true))

            movie = Movie.new(movie_data)

            expect(movie).to be_a(Movie)
            expect(movie.title).to eq("The Shawshank Redemption")
            expect(movie.release_year).to eq(1994)
            expect(movie.vote_average).to eq(8.709)
            expect(movie.runtime).to eq("2 hours, 22 minutes")
            expect(movie.genres).to eq(["Drama", "Crime"])
            expect(movie.summary).to eq("Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
            expect(movie.cast.count).to be <= 10
            expect(movie.total_reviews).to eq(17)
            expect(movie.reviews.count).to be <= 5
        end
    end
end