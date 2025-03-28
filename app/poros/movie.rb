class Movie 
    attr_reader :title,
                :vote_average,
                :id,
                :summary

    def initialize(movie_hash)
        @title = movie_hash[:title]
        @release_date = movie_hash[:release_date]
        @vote_average = movie_hash[:vote_average]
        @runtime = movie_hash[:runtime]
        @genres = movie_hash[:genres]
        @summary = movie_hash[:overview]
        @cast = movie_hash[:cast]
        @reviews = movie_hash[:results]
        @id = movie_hash[:id]
    end

    def release_year 
        @release_date[0..3].to_i
    end

    def runtime 
        "#{@runtime/60} hours, #{@runtime%60} minutes"
    end

    def genres 
        @genres.map do |genre|
            genre[:name]
        end
    end

    def reviews
        @reviews[0..4]
    end

    def total_reviews
        @reviews.count
    end

    def cast 
        @cast[0..9]
    end
end