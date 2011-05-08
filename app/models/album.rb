class Album < ActiveRecord::Base
  has_many :album_images, :dependent => :destroy, :order => :position
  has_many :images, :through => :album_images, :order => 'album_images.position'

  attr_accessible :title

  validates_presence_of :title
  validates_uniqueness_of :title

  acts_as_list

  scope :ordered, :order => :position
end
