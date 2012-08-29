class Term < ActiveRecord::Base
  attr_accessible :name

  has_many :lessons
  has_many :plans
  has_many :summarizes
end
