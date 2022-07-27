require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  describe 'GET /users/:user_id/posts/:id' do
    before(:each) do
      @user1 = User.create(name: 'John', photo: 'https://rb.gy/6kenwx', bio: 'John is a great person.')
      @user2 = User.create(name: 'Jane', photo: 'https://rb.gy/owxkbp', bio: 'Jane is a great person.')
      @post1 = Post.create(title: 'Post 1', text: 'This is the first post.', author: @user1)
      Comment.create(text: 'This is the first comment.', author: @user2, post: @post1)
      Comment.create(text: 'This is the second comment.', author: @user2, post: @post1)
      Comment.create(text: 'This is the third comment.', author: @user2, post: @post1)
    end

    scenario 'displays the post\'s title' do
      visit user_post_path(user_id: @user1.id, id: @post1.id)
      sleep(2)
      expect(page).to have_content(@post1.title)
    end

    scenario 'displays the author\'s name' do
      visit user_post_path(user_id: @user1.id, id: @post1.id)
      sleep(2)
      expect(page).to have_content(@user1.name)
    end

    scenario 'displays the post\'s text' do
      visit user_post_path(user_id: @user1.id, id: @post1.id)
      sleep(2)
      expect(page).to have_content(@post1.text)
    end

    scenario 'displays how many comments the post has' do
      visit user_post_path(user_id: @user1.id, id: @post1.id)
      sleep(2)
      expect(page).to have_content('Comments: 3')
    end

    scenario 'displays how many likes the post has' do
      visit user_post_path(user_id: @user1.id, id: @post1.id)
      sleep(2)
      expect(page).to have_content('Likes: 0')
    end

    scenario 'displays the user name of each comment' do
      visit user_post_path(user_id: @user1.id, id: @post1.id)
      sleep(2)
      expect(page).to have_content('Jane')
    end

    scenario 'displays the comment text' do
      visit user_post_path(user_id: @user1.id, id: @post1.id)
      sleep(2)
      expect(page).to have_content('This is the first comment.')
    end
  end
end
