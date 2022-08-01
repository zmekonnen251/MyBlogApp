class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.string :bio
      t.integer :posts_counter

      t.timestamps
    end

    add_index :users, :posts_counter, order: {posts_counter: :desc}
  end
end
