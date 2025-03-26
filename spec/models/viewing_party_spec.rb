require "rails_helper"

describe ViewingParty, type: :model do
    describe "validations" do
        it { should validate_presence_of :name }
        it { should validate_presence_of :start_time }
        it { should validate_presence_of :end_time }
        it { should validate_presence_of :movie_id }
    end

    describe "relations" do
        it { should have_many :viewing_party_users }
        it { should have_many(:users).through :viewing_party_users }
    end
end