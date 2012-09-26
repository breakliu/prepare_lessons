class Term < ActiveRecord::Base
  attr_accessible :name

  has_many :lessons
  has_many :plans
  has_many :summarizes
  has_many :group_study_plans
  has_many :group_research_work_plans

  default_scope :order => 'created_at desc'
end
