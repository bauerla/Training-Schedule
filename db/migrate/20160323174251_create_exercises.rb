class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.text :desc
      t.integer :duration
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
