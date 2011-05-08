Factory.define :album_image do |f|
  f.album { Factory(:album) }
  f.image { Factory(:image) }
end
