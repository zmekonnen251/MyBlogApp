class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  def update_likes_counter
    self.post.increment!(:likes_counter)
  end

  def decreament_likes_counter
    self.post.decrement!(:likes_counter)
  end
end
