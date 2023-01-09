class CreateTasks < ActiveRecord::Migration[6.0]

  def change
    create_table :tasks do |t|
      t.string :title, null: false, unique: true
      t.text :to_do, null: false, unique: true

      t.timestamps
    end
  end
end
