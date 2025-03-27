class MovieGateway
    def self.movie_search(search)
        response = conn.get("3/search/movie?query=#{search}")
        poroify(response)
    end

    def self.top_movies 
        response = conn.get("/3/movie/top_rated")
        poroify(response)
    end

    private

    def self.conn
        Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:read_token]
        end
    end

    def self.poroify(response)
        response = conn.get("/3/movie/top_rated")
        json = JSON.parse(response.body, symbolize_names: true)
        json[:results].map do |movie_data|
            Movie.new(movie_data)
        end
    end
end