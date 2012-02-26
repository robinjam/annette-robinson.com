require 'paperclip_processors/watermark.rb'

class Image < ActiveRecord::Base
  has_many :album_images, :dependent => :destroy
  has_many :albums, :through => :album_images

  attr_accessible :title, :image

  if Rails.env.production?
    STORAGE_OPTIONS = {
      :storage => :s3,
      :bucket => 'annette-robinson',
      :s3_credentials => {
        :access_key_id => ENV['S3_ACCESS_KEY_ID'],
        :secret_access_key => ENV['S3_SECRET_ACCESS_KEY']
      }
    }
  else
    STORAGE_OPTIONS = {
      :url => '/:class/:id/:style.:extension',
      :path => ':rails_root/uploads/:attachment/:id/:style'
    }
  end

  has_attached_file :image, {
      :processors => [:watermark],
      :styles => {
        :medium => {
          :geometry => "1000x400>",
          :format => 'jpg',
          :watermark_path => "#{Rails.root}/uploads/watermark.png"
        }
      },
      :default_style => :medium,
      :path => "/:style/:id/:filename"
    }.merge(STORAGE_OPTIONS)

  validates_presence_of :title

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /^image\/.+$/
  validates_attachment_size :image, :less_than => 10.megabytes
end
