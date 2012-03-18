# encoding: utf-8
class Lesson < ActiveRecord::Base
  COURSES = %w[语文 数学 英语 美术 音乐 体育 科学 信息技术 心理健康]
  GRADES = %w[一年级 二年级 三年级 四年级 五年级 六年级]
  VOLUMES = %w[第一册 第二册 第三册 第四册 第五册 第六册 第七册 第八册 第九册 第十册 第十一册 第十二册]
  UNITS = %w[第一单元 第二单元 第三单元 第四单元 第五单元 第六单元 第七单元 第八单元 第九单元 第十单元 第十一单元 第十二单元]
  
  has_many :lesson_hours, :dependent => :destroy
  accepts_nested_attributes_for :lesson_hours, :reject_if => :all_blank, :allow_destroy => true
  
  attr_accessible :lesson_hours_attributes, :title, :goal_knowledge, :goal_ability, :goal_emotion, 
                  :unit_emphasis, :teaching_emphasis, :teaching_difficulty, :teaching_method, :teaching_ready,
                  :course, :grade, :volume, :unit
  
  validates_presence_of :title
end
