class CreateLessonHours < ActiveRecord::Migration
  def change
    create_table :lesson_hours do |t|
      t.string :name
      t.integer :lesson_id
      t.text :content

      t.timestamps
    end
  end
end
