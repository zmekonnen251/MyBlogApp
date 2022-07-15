# frozen_string_literal: true

class UpdatePostsCommentCounter < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :comments_counter, :integer, default: 0
  end
end
