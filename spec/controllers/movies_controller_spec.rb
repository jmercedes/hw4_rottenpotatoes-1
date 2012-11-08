require 'spec_helper'

describe MoviesController do
  describe 'find movies with same director' do
    it 'should call the model method that performs the search' do
     Movie.should_receive(:find_similar_director).with('1')
     visit '/movies/1/similar_director'
    end
    it 'should select the Similar Director template for rendering' do
      Movie.stub(:find_similar_director)
      visit '/movies/1/similar_director'
      response.should render_template('similar_director')
    end
    it 'should make the similar director results available to that template' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_similar_director).and_return(fake_results)
      visit '/movies/1/similar_director'
      assigns[:movies].should eq(fake_results)
    end
  end
end
