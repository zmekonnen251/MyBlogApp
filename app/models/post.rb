class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_posts_counter
    User.find(author_id).increment!(:posts_counter)
  end

  def most_recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end
end
