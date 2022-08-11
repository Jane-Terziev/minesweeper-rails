class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards, id: false do |t|
      t.string :id, primary_key: true, limit: 36
      t.string :email, null: false
      t.string :name, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :bombs, null: false

      t.timestamps
    end
  end
end
