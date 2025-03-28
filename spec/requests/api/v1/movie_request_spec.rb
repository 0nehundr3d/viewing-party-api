require "rails_helper"

describe "Movie Api", type: :request do
    describe "Movie Search" do
        it "can use query params to return 20 relevant movie results", :vcr do
            get "/api/v1/movie?search=Matrix"
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(json[:data].count).to be <= 20
            expect(json[:data].first[:id].to_i).to be_a(Integer)
            expect(json[:data].first[:type]).to eq("movie")
            expect(json[:data].first[:attributes][:title]).to be_a(String)
            expect(json[:data].first[:attributes][:vote_average]).to be_a(Float)
        end

        it "returns a 400 error when not adding a search", :vcr do
            get "/api/v1/movie?search"
            json = JSON.parse(response.body, symbolize_names: true)
            
            expect(response).to have_http_status(:bad_request)
            expect(json[:message]).to eq("A search is required for the movie endpoint")
            expect(json[:status]).to eq(400)
        end
    end

    describe "Movie details", type: :reqiest do
        it "returns relevent details on a movie", :vcr do
            get "/api/v1/movie/278"
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status :ok 
            expect(json[:data][:id]).to eq("278")
            expect(json[:data][:type]).to eq("movie")
            expect(json[:data][:attributes][:title]).to eq("The Shawshank Redemption")
            expect(json[:data][:attributes][:release_year]).to eq(1994)
            expect(json[:data][:attributes][:vote_average]).to eq(8.709)
            expect(json[:data][:attributes][:runtime]).to eq("2 hours, 22 minutes")
            expect(json[:data][:attributes][:genres]).to eq(["Drama", "Crime"])
            expect(json[:data][:attributes][:summary]).to eq("Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
            expect(json[:data][:attributes][:cast].count).to be <= 10
            expect(json[:data][:attributes][:total_reviews]).to eq(17)
            expect(json[:data][:attributes][:reviews].count).to be <= 5
        end
    end
end