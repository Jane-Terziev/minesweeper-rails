class CreateBoardMatrix < ActiveRecord::Migration[7.0]
  def change
    create_table :board_matrices, id: false do |t|
      t.string :board_id, primary_key: true, limit: 36
      t.text :matrix, array: true
    end

    add_foreign_key :board_matrices, :boards, column: :board_id, on_delete: :cascade
    add_index :board_matrices, :board_id
  end
end
