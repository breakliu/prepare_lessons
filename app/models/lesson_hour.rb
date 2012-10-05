class LessonHour < ActiveRecord::Base
  belongs_to :lesson

  attr_accessible :thinking, :process_teacher, :process_stu, :process_idea, :evaluate_blackboard, :summary_homework, :content
end
