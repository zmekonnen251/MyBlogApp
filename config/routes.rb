Rails.application.routes.draw do
  devise_for :users 

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[create destroy]
    end
  end

  post 'api_users/auth/login/', to: 'api/authentication#login', as: :user_login
  post 'api_users/sign_up', to: 'api/users#create',as: :user_signup
  get  'api_users/users_list', to: 'api/users#index',as: :list_all_users
  get  'api_users/get_user', to: 'api/users#show',as: :get_user
  get  'api_users/:user_id/posts_list', to: 'api/posts#index', as: :list_all_user_posts
  get  'api_users/:user_id/posts/:post_id/comments_list', to: 'api/comments#index', as: :list_all_user_post_comments
  post 'api_users/:user_id/posts/:post_id/comments', to: 'api/comments#create', as: :add_comment

  root to: 'users#index'
end
