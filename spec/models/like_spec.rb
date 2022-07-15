require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    @post = Post.create(title: 'Post title', text: 'Post text', author: @user)
  end

  it 'it should create a like' do
    like = Like.create(author: @user, post: @post)
    expect(like).to be_valid
  end

  it 'The like counter should be incremented' do
    like = Like.create(author: @user, post: @post)
    like.update_likes_counter
    expect(Post.first.likes_counter).to eq(1)
  end
end
