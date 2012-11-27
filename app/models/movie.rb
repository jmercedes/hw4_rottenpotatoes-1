class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_similar_director(id)
    movie_caller = find_by_id(id)
    director = movie_caller.director
    all_directors = Movie.find_all_by_director(director)
    all_directors.delete(movie_caller)
    return all_directors
  end
end
