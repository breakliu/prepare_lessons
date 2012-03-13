class Lesson < ActiveRecord::Base
  has_many :lesson_hours, :dependent => :destroy
  accepts_nested_attributes_for :lesson_hours
  
  attr_accessible :lesson_hours_attributes, :title, :goal_knowledge, :goal_ability, :goal_emotion, 
  :unit_emphasis, :teaching_emphasis, :teaching_difficulty, :teaching_method, :teaching_ready
end
