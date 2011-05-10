class Image < ActiveRecord::Base
  has_many :album_images, :dependent => :destroy
  has_many :albums, :through => :album_images

  attr_accessible :title, :image

  has_attached_file :image, :styles => { :medium => ["1000x400>", :jpg] },
    :default_style => :medium,
    :url => '/:class/:id/:style/:filename',
    :path => ':rails_root/uploads/:attachment/:id/:style'

  validates_presence_of :title

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /^image\/.+$/
  validates_attachment_size :image, :less_than => 10.megabytes
end
