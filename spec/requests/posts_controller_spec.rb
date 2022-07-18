require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  describe 'GET /users/1/posts' do
    it 'returns a list of posts for a given user' do
      get '/users/1/posts'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Here is a list of posts for a given user.')
    end

    it 'renders the index.html.erb template' do
      get '/users/1/posts'
      expect(response).to render_template('index')
    end
  end

  describe 'GET /users/1/posts/1' do
    it 'returns a single post for a given user' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Here is a post for a given user and id of the post.')
    end

    it 'renders a show.html.erb template' do
      get '/users/1/posts/1'
      expect(response).to render_template('show')
    end
  end
end
