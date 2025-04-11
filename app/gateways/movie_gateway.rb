class MovieGateway
    def self.movie_search(search)
        response = conn.get("3/search/movie?query=#{search}")
        poroify(response)
    end

    def self.top_movies 
        response = conn.get("/3/movie/top_rated")
        poroify(response)
    end

    def self.fetch_movie_runtime(movie_id)
        response = conn.get("/3/movie/#{movie_id}")
        json = JSON.parse(response.body, symbolize_names: true)

        return json[:runtime]
    end

    def self.fetch_movie_details(movie_id)
        details = conn.get("/3/movie/#{movie_id}")
        credits = conn.get("/3/movie/#{movie_id}/credits")
        reviews = conn.get("/3/movie/#{movie_id}/reviews")
        json = JSON.parse(details.body, symbolize_names: true)
        .merge(JSON.parse(credits.body, symbolize_names: true))
        .merge(JSON.parse(reviews.body, symbolize_names: true))

        return Movie.new(json)
    end

    private

    def self.conn
        Faraday.new(url: "https://api.themoviedb.org") do |faraday|
            faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:read_token]
        end
    end

    def self.poroify(response)
        json = JSON.parse(response.body, symbolize_names: true)
        json[:results].map do |movie_data|
            Movie.new(movie_data)
        end
    end
end