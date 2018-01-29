class Album < ApplicationRecord
  has_many :album_images, -> { order :position }, :dependent => :destroy
  has_many :images, -> { order 'album_images.position' }, :through => :album_images

  validates_presence_of :title
  validates_uniqueness_of :title

  acts_as_list

  scope :ordered, -> { order :position }

  def images_not_present
    conditions = ['id NOT IN (?)', album_images.map(&:image_id)] unless album_images.empty?
    Image.where(conditions).order(:title)
  end

  def to_param
    "#{id}-#{title.downcase.gsub(/[^[:alnum:]]+/, '-')}"
  end
end
