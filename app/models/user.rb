class User < ActiveRecord::Base
  has_many :lessons, :dependent => :destroy
  has_many :plans
  has_many :summarizes
  authenticates_with_sorcery!
  
  attr_accessible :username, :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
end
