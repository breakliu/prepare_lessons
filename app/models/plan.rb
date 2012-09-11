class Plan < ActiveRecord::Base

  belongs_to :user
  belongs_to :term
  validates_presence_of :title

  attr_accessible :content, :course, :title, :term_id, :user_id, :grade

  self.per_page = 15
  
  default_scope :order => 'created_at desc'
end
