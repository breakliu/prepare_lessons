class Group < ActiveRecord::Base
  has_many :group_study_plans
  has_many :group_research_work_plans

  validates_presence_of :name
  
  attr_accessible :name
end
