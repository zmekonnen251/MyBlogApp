Rails.application.routes.draw do
  root 'home#index'
  get '/users/:user_id/posts', to:'posts#index', as: :user_posts
  get '/users/:user_id/posts/:id', to:'posts#show', as: :user_post
  get '/users', to:'users#index', as: :users
  get '/users/:id', to:'users#show', as: :user
  get '/posts/new', to:'posts#new', as: :new_post
  get '/users/:user_id/posts/:id/comments/new_comment', to:'posts#new_comment', as: :new_comment
  put '/users/:user_id/posts/:id/like', to:'posts#like', as: :like
  post '/posts', to:'posts#create', as: :posts
  post '/users/:user_id/posts/:id/comments', to:'posts#create_comment', as: :comments

end
