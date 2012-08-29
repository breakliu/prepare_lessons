class Term < ActiveRecord::Base
  attr_accessible :name

  has_many :lessons
  has_many :plans
  has_many :summarizes

  default_scope :order => 'created_at desc'
end
