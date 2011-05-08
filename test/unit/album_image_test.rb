require 'test_helper'

class AlbumImageTest < ActiveSupport::TestCase
  should belong_to :album
  should belong_to :image

  should "act as list scoped to album" do
    a1 = Factory(:album)
    a2 = Factory(:album)
    obj1 = Factory(:album_image, :album => a1)
    obj2 = Factory(:album_image, :album => a1)
    obj3 = Factory(:album_image, :album => a2)

    assert_equal 1, obj1.position
    assert_equal 2, obj2.position
    assert_equal 1, obj3.position
  end
end
