# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    @post = Post.create(title: 'Post title', text: 'Post text', author: @user)
    @user2 = User.create(name: 'test name2', bio: 'test bio2', photo: 'www.photourl.com/test2.jpg')
    @post2 = Post.create(title: 'Post title2', text: 'Post text2', author: @user2)
  end

  it 'it should create a comment' do
    comment = Comment.create(text: 'Comment text', author: @user, post: @post)
    expect(comment).to be_valid
  end

  it 'The comment counter should be incremented' do
    comment = Comment.create(text: 'Comment text', author: @user, post: @post)
    comment.update_comments_counter
    expect(Post.first.comments_counter).to eq(1)
  end

  it 'The comment counter should be incremented for multiple comments for a post' do
    comment = Comment.create(text: 'Comment text', author: @user, post: @post2)
    comment.update_comments_counter
    comment = Comment.create(text: 'Comment text', author: @user2, post: @post2)
    comment.update_comments_counter
    expect(Post.second.comments_counter).to eq(2)
  end
end
