class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  def update_likes_counter
    Post.find_by(post_id: post_id).increment!(:likes_counter)
  end
end
