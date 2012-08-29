class CreateLessonHours < ActiveRecord::Migration
  def change
    create_table :lesson_hours do |t|
      t.integer :lesson_id, :null => false
      
      t.text :process_teacher
      t.text :process_stu
      t.text :process_idea
      t.text :evaluate_blackboard
      t.text :summary_homework
      t.text :thinking

      t.timestamps
    end
  end
end
