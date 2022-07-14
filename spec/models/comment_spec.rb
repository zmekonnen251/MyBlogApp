require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name:'test name',bio: 'test bio', photo:'www.photourl.com/test.jpg')
    @post = Post.create(title: 'Post title', text: 'Post text',author: @user)
  end
  
  it 'it should create a comment' do
    comment = Comment.create(text: 'Comment text', author: @user, post: @post)
    expect(comment).to be_valid
  end

  it 'The comment counter should be incremented' do
    comment = Comment.create(text: 'Comment text', author: @user, post: @post)
    comment.update_comments_counter
    expect(@post.comments_counter).to eq(1)
  end

end
