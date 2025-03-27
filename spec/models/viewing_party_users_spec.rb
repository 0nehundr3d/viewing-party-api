require "rails_helper"

describe ViewingPartyUser, type: :model do
    describe "validations" do
        it { should validate_inclusion_of(:host).in_array([true,false]) }
    end
    describe "relations" do
        it { should belong_to :user }
        it { should belong_to :viewing_party }
    end
end