class CreateTasks < ActiveRecord::Migration[6.0]
  # change_column :tasks, :title, :string, null: false
  # change_column :tasks, :title, :string, unique: true
  # change_column :tasks, :to_do, :text, null: false

  def change
    create_table :tasks do |t|
      t.string :title, null: false, unique: true
      t.text :to_do, null: false, unique: true

      t.timestamps
    end
  end
end
