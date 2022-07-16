require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'it should create a post' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    post = Post.create(title: 'Post title', text: 'Post text', author: user)
    expect(post).to be_valid
  end

  it 'The post title should be present' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    post = Post.create(text: 'Post text', author: user)
    expect(post).to be_invalid
  end

  it 'The post title length should be below 250 characters' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    post = Post.create(title: 'Post title', text: 'Post text', author: user)
    expect(post).to be_valid
  end

  it 'It should update the posts counter' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    post = Post.create(title: 'Post title', text: 'Post text', author: user)
    post.update_posts_counter
    expect(User.first.posts_counter).to eq(1)
  end

  it 'It should have a comments counter' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    post = Post.create(title: 'Post title', text: 'Post text', author: user)
    expect(post.comments_counter).to eq(0)
  end

  it 'It should return most recent 5 comments for a give post' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    post = Post.create(title: 'Post title', text: 'Post text', author: user)
    comment2 = Comment.create(text: 'Comment text2', author: user, post: post)
    comment3 = Comment.create(text: 'Comment text3', author: user, post: post)
    comment4 = Comment.create(text: 'Comment text4', author: user, post: post)
    comment5 = Comment.create(text: 'Comment text5', author: user, post: post)
    comment6 = Comment.create(text: 'Comment text6', author: user, post: post)

    expect(Post.first.most_recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
  end
end
