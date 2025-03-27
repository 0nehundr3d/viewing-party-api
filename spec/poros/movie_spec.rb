require "rails_helper"

RSpec.describe Movie do
    describe "#initialize" do
        it "Should be able to create a movie object from a hash" do
            movie_data = {
                adult: false,
                backdrop_path: "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg",
                genre_ids: [
                    18,
                    80
                ],
                id: 278,
                original_language: "en",
                original_title: "The Shawshank Redemption",
                overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
                popularity: 28.6761,
                poster_path: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
                release_date: "1994-09-23",
                title: "The Shawshank Redemption",
                video: false,
                vote_average: 8.708,
                vote_count: 27967
            }

            movie = Movie.new(movie_data)

            expect(movie.title).to eq("The Shawshank Redemption")
            expect(movie.vote_average).to eq(8.708)
            expect(movie.id).to eq(278)
        end
    end
end