class ChangeColumnsNotnullAddTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :title, :string, null: false
    change_column :tasks, :to_do, :text, null: false
  end
end
