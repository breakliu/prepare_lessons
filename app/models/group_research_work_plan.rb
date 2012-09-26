class GroupResearchWorkPlan < ActiveRecord::Base
  belongs_to :user
  belongs_to :term
  belongs_to :group
  validates_presence_of :title

  self.per_page = 15
  default_scope :order => 'created_at desc'
  
  attr_accessible :content, :group_id, :term_id, :title, :user_id
end
