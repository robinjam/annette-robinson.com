class AlbumImage < ActiveRecord::Base
  belongs_to :album
  belongs_to :image

  acts_as_list :scope => :album
end
