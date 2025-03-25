require "rails_helper"

describe "Top Movies Endpoints", :type => :request do
    describe "GET Top movies" do
        it "should return a list of the top 20 highest rated movies", :vcr do
            get "/api/v1/movie/top"
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(json[:data].count).to eq(20)
            expect(json[:data].first[:id].to_i).to be_a(Integer)
            expect(json[:data].first[:type]).to eq("movie")
            expect(json[:data].first[:attributes][:title]).to be_a(String)
            expect(json[:data].first[:attributes][:vote_average]).to be_a(Float)
        end
    end
end