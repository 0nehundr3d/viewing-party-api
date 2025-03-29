require "rails_helper"

describe "Viewing Party API", type: :request do
    before :each do
        3.times do |i|
            User.create!(name: i, username: i, password: "testingUser")
        end
    end

    let(:party_params) do
        {
            "name": "Juliet's Bday Movie Bash!",
            "start_time": "2025-02-01 10:00:00",
            "end_time": "2025-02-01 14:30:00",
            "movie_id": 278,
            "movie_title": "The Shawshank Redemption",
            "invitees": User.all.pluck(:id)
        }
    end

    describe "Create viewing party endpoint" do
        it "returns a 201 Created and provies expected fields" do
            post "/api/v1/users/#{User.first[:id]}/party", params: party_params, as: :json
            json = JSON.parse(response.body, symbolize_names: true)
            # binding.pry
            expect(response).to have_http_status(:created)
            expect(json[:data][:type]).to eq("viewing_party")
            expect(json[:data][:id]).to eq(ViewingParty.last.id.to_s)
            expect(json[:data][:attributes][:name]).to eq("Juliet's Bday Movie Bash!")
            expect(json[:data][:attributes][:start_time]).to eq("2025-02-01 10:00:00")
            expect(json[:data][:attributes][:end_time]).to eq("2025-02-01 14:30:00")
            expect(json[:data][:attributes][:movie_id]).to eq(278)
            expect(json[:data][:attributes][:movie_title]).to eq("The Shawshank Redemption")
            expect(json[:data][:attributes][:invitees].count).to eq(3)
        end

        it "returns a 400 bad request when not given all required params" do
            post "/api/v1/users/#{User.first[:id]}/party", params: {name:"test"}, as: :json
            json = JSON.parse(response.body, symbolize_names: true)
            
            expect(response).to have_http_status(:bad_request)
            expect(json[:message]).to eq("Missing required params start_time, end_time, movie_id, movie_title for creating viewing party")
        end

        it "returns a 400 bad request when the party duration is less than the runtime of the movie" do
            params = {
                "name": "Juliet's Bday Movie Bash!",
                "start_time": "2025-02-01 10:00:00",
                "end_time": "2025-02-01 10:30:00",
                "movie_id": 278,
                "movie_title": "The Shawshank Redemption",
                "invitees": User.all.pluck(:id)
            }
            post "/api/v1/users/#{User.first[:id]}/party", params: params, as: :json
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:bad_request)
            expect(json[:message]).to eq("Can not create a viewing party with less duration than the movie being viewed (142 minutes)")
        end

        it "returns a 400 bad request when the party ends before it starts" do
            params = {
                "name": "Juliet's Bday Movie Bash!",
                "end_time": "2025-02-01 10:00:00",
                "start_time": "2025-02-01 10:30:00",
                "movie_id": 278,
                "movie_title": "The Shawshank Redemption",
                "invitees": User.all.pluck(:id)
            }
            post "/api/v1/users/#{User.first[:id]}/party", params: params, as: :json
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:bad_request)
            expect(json[:message]).to eq("Can not create a viewing party with and end time before its begin time")
        end
    end

    describe "Add users to viewing party" do
        it "should be able to add users to an existing viewing party" do
            post "/api/v1/users/#{User.first[:id]}/party", params: party_params, as: :json
            new_user = User.create!(name: "test user", username: "test user", password: "test")
            patch "/api/v1/users/#{User.first[:id]}/party/#{ViewingParty.first[:id]}", params: { "invitees_user_id": new_user.id }, as: :json
            json = JSON.parse(response.body, symbolize_names: true)
            # binding.pry

            expect(response).to have_http_status :ok 
            expect(json[:data][:attributes][:invitees]).to include({:id=>new_user.id, :name=>"test user", :username=>"test user"})
        end

        it "should return a 404 when trying to add to a non existant party" do
            patch "/api/v1/users/#{User.first[:id]}/party/999", params: { "invitees_user_id": 26 }, as: :json
            json = JSON.parse(response.body, symbolize_names: true)
            # binding.pry
            expect(response).to have_http_status :not_found
            expect(json[:message]).to eq("Could not find ViewingParty with id 999")
        end

        it "should return a 404 when trying to add a non existant user to a party" do
            post "/api/v1/users/#{User.first[:id]}/party", params: party_params, as: :json
            patch "/api/v1/users/#{User.first[:id]}/party/#{ViewingParty.first[:id]}", params: { "invitees_user_id": 9999999 }, as: :json
            json = JSON.parse(response.body, symbolize_names: true)
            
            expect(response).to have_http_status :not_found
            expect(json[:message]).to eq("Could not find User with id 9999999")
        end
    end
end