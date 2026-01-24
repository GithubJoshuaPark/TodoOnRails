class AddDetailsToTodos < ActiveRecord::Migration[8.1]
  def change
    add_column :todos, :due_date, :datetime
    add_column :todos, :priority, :integer
  end
end
