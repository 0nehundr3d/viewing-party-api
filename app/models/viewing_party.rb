class ViewingParty < ApplicationRecord
    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :movie_id, presence: true
    has_many :viewing_party_users
    has_many :users, through: :viewing_party_users
end