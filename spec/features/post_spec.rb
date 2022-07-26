require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  describe 'GET /users/:user_id/posts/:id' do
    before(:each) do
      @user_1 = User.create(name:'John',photo: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',bio:'John is a great person.')
      @user_2 = User.create(name:'Jane',photo: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',bio:'Jane is a great person.')
      @post_1 = Post.create(title:'Post 1',text:'This is the first post.',author:@user_1)
      @comment_1 = Comment.create(text:'This is the first comment.',author:@user_2,post:@post_1)
      @comment_2 = Comment.create(text:'This is the second comment.',author:@user_2,post:@post_1)
      @comment_3 = Comment.create(text:'This is the third comment.',author:@user_2,post:@post_1)
      
      @user_1.save
      @user_2.save
      @post_1.save
  
      @comment_1.save
      @comment_2.save
      @comment_3.save
    end

    scenario 'displays the post\'s title' do
      visit user_post_path(user_id:@user_1.id,id:@post_1.id)
      sleep(2)
      expect(page).to have_content('Post 1')
    end

    scenario 'displays the author\'s name' do
      visit user_post_path(user_id:@user_1.id,id:@post_1.id)
      sleep(2)
      expect(page).to have_content('John')
    end

    scenario 'displays the post\'s text' do
      visit user_post_path(user_id:@user_1.id,id:@post_1.id)
      sleep(2)
      expect(page).to have_content('This is the first post.')
    end

    scenario 'displays how many comments the post has' do
      visit user_post_path(user_id:@user_1.id,id:@post_1.id)
      sleep(2)
      expect(page).to have_content('Comments: 3')
    end

    scenario 'displays how many likes the post has' do
      visit user_post_path(user_id:@user_1.id,id:@post_1.id)
      sleep(2)
      expect(page).to have_content('Likes: 0')
    end

    scenario 'displays the user name of each comment' do
      visit user_post_path(user_id:@user_1.id,id:@post_1.id)
      sleep(2)
      expect(page).to have_content('Jane')
    end

    scenario 'displays the comment text' do
      visit user_post_path(user_id:@user_1.id,id:@post_1.id)
      sleep(2)
      expect(page).to have_content('This is the first comment.')
    end
  end
end