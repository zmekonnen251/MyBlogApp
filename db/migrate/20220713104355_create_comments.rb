class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.timestamps
    end

    add_reference :comments, :post, foreign_key: {to_table: :posts}
    add_reference :comments, :author, foreign_key: {to_table: :users}
  end
end
