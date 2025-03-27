class Movie 
    attr_reader :title,
                :vote_average,
                :id

    def initialize(movie_hash)
        @title = movie_hash[:title]
        @vote_average = movie_hash[:vote_average]
        @id = movie_hash[:id]
    end
end