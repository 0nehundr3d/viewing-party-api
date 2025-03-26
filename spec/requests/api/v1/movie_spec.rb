require "rails_helper"

describe "Movie Api", type: :request do
    describe "Movie Search" do
        it "can use query params to return 20 relevant movie results" do
            get "/api/v1/movie?search=Matrix"
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(json[:data].count).to be <= 20
            expect(json[:data].first[:id].to_i).to be_a(Integer)
            expect(json[:data].first[:type]).to eq("movie")
            expect(json[:data].first[:attributes][:title]).to be_a(String)
            expect(json[:data].first[:attributes][:vote_average]).to be_a(Float)
        end
    end
end