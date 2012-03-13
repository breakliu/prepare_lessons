class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title, :null => false
      
      t.text :goal_knowledge
      t.text :goal_ability
      t.text :goal_emotion
      t.text :unit_emphasis
      t.text :teaching_emphasis
      t.text :teaching_difficulty
      t.text :teaching_method
      t.text :teaching_ready

      t.timestamps
    end
  end
end
