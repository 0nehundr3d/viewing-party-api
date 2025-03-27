class ViewingParty < ApplicationRecord
    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :movie_id, presence: true
    validates :movie_title, presence: true
    has_many :viewing_party_users
    has_many :users, through: :viewing_party_users

    def invite_users(users)
        users.each do |user_id|
            ViewingPartyUser.create!(viewing_party: self, user: User.where(id: user_id)[0])
        end
    end
end