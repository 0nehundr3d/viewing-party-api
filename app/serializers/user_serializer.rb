class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :username, :api_key

  def self.format_user_list(users)
    { data:
        users.map do |user|
          {
            id: user.id.to_s,
            type: "user",
            attributes: {
              name: user.name,
              username: user.username
            }
          }
        end
    }
  end

  def self.format_user_details(user)
    hosted_parties = user.viewing_party_users.where(host: true).map do |party_user|
      party = party_user.viewing_party
      {
        name: party.name,
        start_time: party.start_time,
        end_time: party.end_time,
        movie_title: party.movie_title,
        movie_id: party.movie_id,
        host_id: user.id
      }
    end
    hosted_parties = [] if not hosted_parties

    invited_parties = user.viewing_party_users.where(host:false).map do |party_user|
      party = party_user.viewing_party
      # binding.pry
      {
        name: party.name,
        start_time: party.start_time,
        end_time: party.end_time,
        movie_title: party.movie_title,
        movie_id: party.movie_id,
        host_id: party.viewing_party_users.where(host:true)[0].user.id
      }
    end
    invited_parties = [] if not invited_parties

    {
      data: {
        id: user.id,
        type: "user",
        attributes: {
          name: user.name,
          username: user.username,
          viewing_parties_hosted: hosted_parties,
          viewing_parties_invited: invited_parties
        }
      }
    }
  end
end