require 'rails_helper'

RSpec.describe 'User Views', type: :system do
  before(:all) do
    @user1 = User.create(name: 'John', photo: 'https://rb.gy/6kenwx', bio: 'John is a great person.')
    @user2 = User.create(name: 'Jane', photo: 'https://rb.gy/owxkbp', bio: 'Jane is a great person.')
    @post1 = Post.create(title: 'Post 1', text: 'This is the first post.', author: @user1)
    @post2 = Post.create(title: 'Post 2', text: 'This is the second post.', author: @user1)
    @post3 = Post.create(title: 'Post 3', text: 'This is the third post.', author: @user1)
    Comment.create(text: 'This is the first comment.', author: @user2, post: @post1)
    Comment.create(text: 'This is the second comment.', author: @user2, post: @post2)
    Comment.create(text: 'This is the third comment.', author: @user2, post: @post3)
  end

  describe 'GET /users/index' do
    feature 'User index page' do
      scenario 'displays a list of users' do
        visit users_path
        sleep(2)
        expect(page).to have_content('John')
        expect(page).to have_content('Jane')
      end

      scenario 'Displays a profile image for each user' do
        visit users_path
        sleep(2)
        expect(page).to have_css("img[src*='https://rb.gy/6kenwx']")
        expect(page).to have_css("img[src*='https://rb.gy/owxkbp']")
      end

      scenario 'Displays the number of posts each user has written' do
        visit users_path
        sleep(2)
        expect(page).to have_content('Number of Posts: 1')
        expect(page).to have_content('Number of Posts: 2')
      end

      scenario 'When user clicked it will redirect to user show page' do
        visit users_path
        sleep(2)
        click_link(id: 'john')
        sleep(2)
        expect(page.current_path).to eq user_path(id: @user1.id)
      end
    end
  end

  describe 'User show page GET /users/1' do
    scenario 'displays a user\'s photo' do
      visit user_path(id: @user1.id)
      sleep(2)
      expect(page).to have_css("img[src*='https://rb.gy/6kenwx']")
    end

    scenario 'displays a user\'s bio' do
      visit user_path(id: @user1.id)
      sleep(2)
      expect(page).to have_content('John is a great person.')
    end

    scenario 'displays a user\'s number of posts' do
      visit user_path(id: @user1.id)
      sleep(2)
      expect(page).to have_content('Number of Posts: 3')
    end

    scenario 'displays a user\'s first three posts' do
      visit user_path(id: @user1.id)
      sleep(2)
      expect(page).to have_content('Post 1')
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 3')
    end

    scenario 'displays a see all posts button' do
      visit user_path(id: @user1.id)
      sleep(2)
      expect(page).to have_button('See All Posts')
    end

    scenario 'When a post is clicked it will redirect to post show page' do
      visit user_path(id: @user1.id)
      sleep(2)
      click_link(id: 'post 1')
      sleep(2)
      expect(page.current_path).to eq user_post_path(id: @post1.id, user_id: @post1.author.id)
    end

    scenario 'When a see all posts button is clicked it will redirect to user show page' do
      visit user_path(id: @user1.id)
      sleep(2)
      click_button('See All Posts')
      sleep(2)
      expect(page.current_path).to eq user_posts_path(user_id: @user1.id)
    end
  end

  describe 'User posts index page GET /users/1/posts' do
    scenario 'displays a user\'s name' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_content('John')
    end

    scenario 'displays a user\'s photo' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_css("img[src*='https://rb.gy/6kenwx']")
    end

    scenario 'displays the number of posts the user has written' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_content('Number of Posts: 3')
    end

    scenario 'displays the posts title' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_content('Post 1')
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 3')
    end

    scenario 'displays some of the posts text' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_content('This is the first post.')
      expect(page).to have_content('This is the second post.')
      expect(page).to have_content('This is the third post.')
    end

    scenario 'displays the first comments of all the posts' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_content('This is the first comment.')
    end

    scenario 'displays the number of comments the user has written' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_content('Comments: 1')
    end

    scenario 'displays how many likes the post has' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_content('Likes: 0')
    end

    scenario 'displays a pagination button' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      expect(page).to have_button('Pagination')
    end

    scenario 'When a post is clicked it will redirect to post show page' do
      visit user_posts_path(user_id: @user1.id)
      sleep(2)
      click_link(id: 'post 1')
      sleep(2)
      expect(page.current_path).to eq user_post_path(id: @post1.id, user_id: @post1.author.id)
    end
  end
end
