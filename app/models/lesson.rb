class Lesson < ActiveRecord::Base
  has_many :lesson_hours
  accepts_nested_attributes_for :lesson_hours
  
  attr_accessible :lesson_hours_attributes, :name
end
