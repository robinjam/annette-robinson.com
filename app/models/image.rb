require 'paperclip_processors/watermark.rb'

class Image < ActiveRecord::Base
  has_many :album_images, :dependent => :destroy
  has_many :albums, :through => :album_images

  has_attached_file :image, {
      :processors => [:watermark],
      :styles => {
        :medium => {
          :geometry => "x1000>",
          :format => 'jpg',
          :watermark_path => "#{Rails.root}/lib/assets/images/watermark.png"
        }
      },
      :default_style => :medium,
      :use_timestamp => false
    }

  validates_presence_of :title

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /^image\/.+$/

  def too_small?
    image.height < 1000
  end
end
