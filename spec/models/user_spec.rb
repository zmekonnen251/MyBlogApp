require 'rails_helper'

RSpec.describe User, type: :model do
  it 'it should create a user' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    expect(user).to be_valid
  end

  it 'The user name should be present' do
    user = User.create(bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    expect(user).to be_invalid
  end

  it 'The user name length should be below 50 characters' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    expect(user).to be_valid
  end

  it 'Should return most recent three posts for a given user' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    post2 = Post.create(title: 'Post title2', text: 'Post text2', author: user)
    post3 = Post.create(title: 'Post title3', text: 'Post text3', author: user)
    post4 = Post.create(title: 'Post title4', text: 'Post text4', author: user)
    expect(User.first.most_recent_posts).to eq([post4, post3, post2])
  end
end
