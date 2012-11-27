require 'spec_helper'

describe Movie do
  describe 'searching similar director by id' do
#it 'should call Tmdb with title keywords' do
#      TmdbMovie.should_receive(:find).with(hash_including :title => 'Inception')
#      Movie.find_in_tmdb('Inception')
#    end
  before(:each) do
    empty_database
    test_movies = [{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Ridley Scott'},
        {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984', :director => 'Ridley Scott'}]
    @fake_movies = Movie.create!(test_movies)
  end

  it 'should call find_by_id to retreive the movie model currently selected' do
    Movie.should_receive(:find_by_id).with(@fake_movies[0].id).and_return(@fake_movies[0])
    Movie.find_similar_director(@fake_movies[0].id)
  end
  it 'should call find_all_by_director to all movies with the same director' do
    Movie.should_receive(:find_all_by_director).with(@fake_movies[0].director).and_return(@fake_movies)
    Movie.find_similar_director(@fake_movies[0].id)
  end
  it 'should get all movies with that director' do
    movie_caller = Movie.find_by_id(@fake_movies.first.id)
    director = movie_caller.director
    all_movies = Movie.find_all_by_director(director)
    all_movies.sort.should eq(@fake_movies.sort)
  end
  it 'should not return the movie caller' do
    Movie.find_similar_director(@fake_movies[0].id).should_not include(@fake_movies[0])
  end
  it 'should return a list of movies with similar director' do
    Movie.find_similar_director(@fake_movies[0].id).should == [@fake_movies[1]]
  end
  end
end
