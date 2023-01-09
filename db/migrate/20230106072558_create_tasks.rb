class CreateTasks < ActiveRecord::Migration[6.0]

  def change
    create_table :tasks do |t|
      t.string :title
      t.text :to_do
      end
      t.timestamps
    end
  end
end
