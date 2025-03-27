require "rails_helper"

describe "Viewing Party API", type: :request do
    describe "Create viewing party endpoint" do
        let(:party_params) do
            {
                "name": "Juliet's Bday Movie Bash!",
                "start_time": "2025-02-01 10:00:00",
                "end_time": "2025-02-01 14:30:00",
                "movie_id": 278,
                "movie_title": "The Shawshank Redemption",
                "invitees": [2, 3]
            }
        end

        it "returns a 201 Created and provies expected fields" do
            post "/api/v1/users/1/party", params: party_params, as: :json
            json = JSON.parse(response.body, symbolize_names: true)
            binding.pry
            expect(response).to have_http_status(:created)
            expect(json[:data][:type]).to eq("viewing_party")
            expect(json[:data][:id]).to eq(ViewingParty.last.id.to_s)
            expect(json[:data][:attributes][:name]).to eq("Juliet's Bday Movie Bash!")
            expect(json[:data][:attributes][:start_time]).to eq("2025-02-01 10:00:00")
            expect(json[:data][:attributes][:end_time]).to eq("2025-02-01 14:30:00")
            expect(json[:data][:attributes][:movie_id]).to eq(278)
            expect(json[:data][:attributes][:movie_title]).to eq("The Shawshank Redemption")
            expect(json[:data][:attributes][:invitees].count).to eq(2)
        end
    end
end