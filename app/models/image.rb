class Image < ActiveRecord::Base
  attr_accessible :title, :image

  has_attached_file :image, :styles => { :medium => ["1000x400>", :jpg] }

  validates_presence_of :title

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /^image\/.+$/
  validates_attachment_size :image, :less_than => 10.megabytes
end
