class Album < ActiveRecord::Base
  attr_accessible :title

  validates_presence_of :title
  validates_uniqueness_of :title

  acts_as_list

  scope :ordered, :order => :position
end
