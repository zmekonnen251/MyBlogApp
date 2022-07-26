require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  describe 'GET /users/index' do
    before(:each) do
      @user_1 = User.create(name:'John',photo: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',bio:'John is a great person.')
      @user_2 = User.create(name:'Jane',photo: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',bio:'Jane is a great person.')

      @post_1 = Post.create(title:'Post 1',text:'This is the first post.',author:@user_1)
      @post_2 = Post.create(title:'Post 2',text:'This is the second post.',author:@user_2)
      @post_3 = Post.create(title:'Post 3',text:'This is the third post.',author:@user_2)
      @post_1.save
      @post_2.save
      @user_1.save
      @user_2.save
    end

    feature 'User index page' do
      # background { visit users_path}
      scenario 'displays a list of users' do
        visit users_path
        sleep(2)
        expect(page).to have_content('John')
        expect(page).to have_content('Jane')
      end

      scenario 'Displays a profile image for each user' do
        visit users_path
        sleep(2)
        expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80']")
        expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80']")
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
        click_link @user_1.name
        # visit '/users/7'
        sleep(2)
        expect(page.current_path).to eq user_path(@user_1.id)
      end
    end
  end
end

RSpec.describe 'User show page', type: :feature do
  describe 'GET /users/1' do
    before(:each) do
      @user_1 = User.create(name:'John',photo: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',bio:'John is a great person.')
      @user_2 = User.create(name:'Jane',photo: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',bio:'Jane is a great person.')

      @post_1 = Post.create(title:'Post 1',text:'This is the first post.',author:@user_1)
      @post_2 = Post.create(title:'Post 2',text:'This is the second post.',author:@user_1)
      @post_3 = Post.create(title:'Post 3',text:'This is the third post.',author:@user_1)
      @post_1.save
      @post_2.save
      @user_1.save
      @user_2.save
    end

    feature 'User show page' do
      scenario 'displays a user\'s name' do
        visit user_path(id:@user_1.id)
        sleep(2)
        expect(page).to have_content('John')
      end

      scenario 'displays a user\'s photo' do
        visit user_path(id:@user_1.id)
        sleep(2)
        expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80']")
      end

      scenario 'displays a user\'s bio' do
        visit user_path(id:@user_1.id)
        sleep(2)
        expect(page).to have_content('John is a great person.')
      end

      scenario 'displays a user\'s number of posts' do
        visit user_path(id:@user_1.id)
        sleep(2)
        expect(page).to have_content('Number of Posts: 3')
      end

      scenario 'displays a user\'s first three posts' do
        visit user_path(id:@user_1.id)
        sleep(2)
        expect(page).to have_content('Post 1')
        expect(page).to have_content('Post 2')
        expect(page).to have_content('Post 3')
      end

      scenario 'displays a see all posts button' do
        visit user_path(id:@user_1.id)
        sleep(2)
        expect(page).to have_button('See All Posts')
      end

      scenario 'When a post is clicked it will redirect to post show page' do
        visit user_path(id:@user_1.id)
        sleep(2)
        click_link(id:'post 1')
        sleep(2)
        expect(page.current_path).to eq user_post_path(id:@post_1.id,user_id:@post_1.author.id)
      end

      scenario 'When a see all posts button is clicked it will redirect to user show page' do
        visit user_path(id:@user_1.id)
        sleep(2)
        click_button('See All Posts')
        sleep(2)
        expect(page.current_path).to eq user_posts_path(user_id:@user_1.id)
      end
    end
  end
end

RSpec.describe 'User posts index page', type: :feature do
  describe 'GET /users/1/posts' do
    before(:each) do
      @user_1 = User.create(name:'John',photo: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',bio:'John is a great person.')
      @user_2 = User.create(name:'Jane',photo: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',bio:'Jane is a great person.')

      @post_1 = Post.create(title:'Post 1',text:'This is the first post.',author:@user_1)
      @post_2 = Post.create(title:'Post 2',text:'This is the second post.',author:@user_1)
      @post_3 = Post.create(title:'Post 3',text:'This is the third post.',author:@user_1)
      @comment_1 = Comment.create(text:'This is the first comment.',author:@user_2,post:@post_1)
      @comment_2 = Comment.create(text:'This is the second comment.',author:@user_2,post:@post_2)
      @comment_3 = Comment.create(text:'This is the third comment.',author:@user_2,post:@post_3)
      @post_1.save
      @post_2.save
      @user_1.save
      @user_2.save
      @comment_1.save
      @comment_2.save
      @comment_3.save
    end

    feature 'User posts index page' do
      scenario 'displays a user\'s name' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_content('John')
      end

      scenario 'displays a user\'s photo' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80']")
      end

      scenario 'displays the number of posts the user has written' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_content('Number of Posts: 3')
      end

      scenario 'displays the posts title' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_content('Post 1')
        expect(page).to have_content('Post 2')
        expect(page).to have_content('Post 3')
      end

      scenario 'displays some of the posts text' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_content('This is the first post.')
        expect(page).to have_content('This is the second post.')
        expect(page).to have_content('This is the third post.')
      end

      scenario 'displays the first comments of all the posts' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_content('This is the first comment.')
      end

      scenario 'displays the number of comments the user has written' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_content('Comments: 1')
      end

      scenario 'displays how many likes the post has' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_content('Likes: 0')
      end
      
      scenario 'displays a pagination button' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        expect(page).to have_button('Pagination')
      end

      scenario 'When a post is clicked it will redirect to post show page' do
        visit user_posts_path(user_id:@user_1.id)
        sleep(2)
        click_link(id:'post 1')
        sleep(2)
        expect(page.current_path).to eq user_post_path(id:@post_1.id,user_id:@post_1.author.id)
      end
    end
  end
end

        

