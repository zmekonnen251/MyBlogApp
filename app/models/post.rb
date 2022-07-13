class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def update_posts_counter
    User.find(author_id).increment!(:posts_counter)
  end

  def self.most_recent_comments
    Comment.order(created_at: :desc).limit(5)
  end
end
