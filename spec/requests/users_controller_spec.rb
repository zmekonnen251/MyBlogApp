require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET /users' do
    it 'returns a list of users' do
      get '/users'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Here is a list of users in the app.')
    end
  end

  describe 'GET /users/1' do
    it 'returns a single user' do
      get '/users/1'
      expect(response).to have_http_status(200)
      expect(response.body).to include('Here is a user for a given id.')
    end
  end
end
