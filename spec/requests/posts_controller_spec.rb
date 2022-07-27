# require 'rails_helper'

# RSpec.describe 'PostsController', type: :request do
#   before(:all) do
#     @user1 = User.create(name: 'John', photo: 'https://rb.gy/6kenwx', bio: 'John is a great person.')
#     @post1 = Post.create(title: 'Post 1', text: 'This is the first post.', author: @user1)
#   end

#   describe 'GET /users/1/posts' do
#     it 'returns a list of posts for a given user' do
#       get '/users/1/posts'
#       expect(response).to have_http_status(200)
#       expect(response.body).to include('Post 1')
#     end

#     it 'renders the index.html.erb template' do
#       get '/users/1/posts'
#       expect(response).to render_template('index')
#     end
#   end

#   describe 'GET /users/1/posts/1' do
#     it 'returns a single post for a given user' do
#       get '/users/1/posts/1'
#       expect(response).to have_http_status(200)
#       expect(response.body).to include('This is the first post.')
#     end

#     it 'renders a show.html.erb template' do
#       get '/users/1/posts/1'
#       expect(response).to render_template('show')
#       expect(response.body).to include('Post 1')
#     end
#   end
# end
