# frozen_string_literal: true

class UpdatePostsLikesCounter < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :likes_counter, :integer, default: 0
  end
end
