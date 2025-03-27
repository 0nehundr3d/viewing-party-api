class ViewingPartySerializer
    def self.serialize(party_data)
        invitee_data = ViewingParty.where(id: party_data[:id])[0].users.pluck(:id, :name, :username)

        {
            data:{
                id: party_data[:id].to_s,
                type: "viewing_party",
                attributes: {
                    name: party_data[:name],
                    start_time: party_data[:start_time],
                    end_time: party_data[:end_time],
                    movie_id: party_data[:movie_id],
                    movie_title: party_data[:movie_title],
                    invitees: invitee_data.map do |invitee|
                        {
                            id: invitee[0],
                            name: invitee[1],
                            username: invitee[2]
                        }
                    end
                }
            }
        }
    end
end