require "rails_helper"

describe ViewingParty, type: :model do
    describe "relations" do
        it { should have_many :viewing_party_users }
        it { should have_many(:users).through :viewing_party_users }
    end
end