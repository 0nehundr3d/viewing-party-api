class ViewingParty < ApplicationRecord
    validates :name, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :movie_id, presence: true
    validates :movie_title, presence: true
    has_many :viewing_party_users
    has_many :users, through: :viewing_party_users

    def invite_users(users, host)
        users.each do |user_id|
            ViewingPartyUser.create!(
                                    viewing_party: self,
                                    user: User.where(id: user_id)[0],
                                    host: user_id == host.to_i
                                    )
            # binding.pry
        end
    end

    def self.validate_params(params)
        # binding.pry
        return (["name", "start_time", "end_time", "movie_id", "movie_title"] - params.keys).empty?
    end
end