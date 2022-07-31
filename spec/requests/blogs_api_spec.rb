require 'swagger_helper'

RSpec.describe 'Blogs API', type: :request do
  path 'api_users/{user_id}/posts_list' do
    parameter name: 'user_id', in: :path, type: :string, description: 'User ID'

    get ('list_all_user_posts') do
      response(200, 'Success') do
        let(:user_id){create(:user).id}

        after do |example|
          example.metadata[:response][:content]={
            'application/json'=>{example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end 
  end

  path 'api_users/{user_id}/posts_list/{post_id}' do
    parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
    parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'

    get ('list_user_post') do
      response(200, 'Success') do
        let(:user_id){create(:user).id}
        let(:post_id){create(:post, user_id: user_id).id}

        after do |example|
          example.metadata[:response][:content]={
            'application/json'=>{example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end 
  end

  path 'api_users/{user_id}/posts_list/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
    parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'

    get ('list_user_post_comments') do
      response(200, 'Success') do
        let(:user_id){create(:user).id}
        let(:post_id){create(:post, user_id: user_id).id}

        after do |example|
          example.metadata[:response][:content]={
            'application/json'=>{example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end 
  end

  
  path 'api_users/{user_id}/posts_list/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
    parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'

    post ('add_comment') do
      response(200, 'Success') do
        let(:user_id){create(:user).id}
        let(:post_id){create(:post, user_id: user_id).id}

        after do |example|
          example.metadata[:response][:content]={
            'application/json'=>{example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end 
  end

  path 'api_users/{user_id}/posts_list/{post_id}/comments/' do
    parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
    parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'

    post ('add_comment') do
      response(200, 'Success') do
        let(:author){create(:user)}
        let(:post){create(:post, user_id: author.id)}
        let(:comment){create(:comment, post: post, author: author)}
        
        after do |example|
          example.metadata[:response][:content]={
            'application/json'=>{example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end

