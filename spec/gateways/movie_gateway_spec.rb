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
end