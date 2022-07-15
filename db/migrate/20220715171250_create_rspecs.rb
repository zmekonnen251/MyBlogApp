class CreateRspecs < ActiveRecord::Migration[7.0]
  def change
    create_table :rspecs do |t|

      t.timestamps
    end
  end
end
