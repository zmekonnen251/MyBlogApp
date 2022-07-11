class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.integer :comments_counter
      t.integer :likes_counter
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :posts, %i[user_id created_at]
  end
end
