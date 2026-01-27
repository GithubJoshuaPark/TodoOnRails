class AddStatusToTodos < ActiveRecord::Migration[8.1]
  def change
    add_column :todos, :status, :string, default: 'R', null: false
    add_index :todos, :status
  end
end
