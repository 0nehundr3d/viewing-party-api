class ViewingPartySerializer
    def initialize(party_data)
        invitee_data = ViewingParty.where(id: party_data[:id]).users.pluck(:id, :name, :username)

        {
            id: party_data[:id],
            type: "viewing_party",
            attributes: {
                name: party_data[:name],
                start_time: party_data[:start_time],
                end_time: party_data[:end_time],
                movie_id: party_data[:movie_id],
                movie_title: MovieGateway.get_title(party_data[:movie_id]),
                invitees: invitee_data.map do |invitee|
                    {
                        id: invitee[0],
                        name: invitee[1],
                        username: invitee[2]
                    }
                end
            }
        }
    end
end