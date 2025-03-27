class MovieGateway
    def self.movie_search(search)
        response = conn.get("3/search/movie?query=#{search}")
        json = JSON.parse(response.body,symbolize_names: true)
    end

    private

    def self.conn
        Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:read_token]
        end
    end
end