require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  should have_many(:album_images).dependent :destroy
  should have_many(:images).through :album_images
  should allow_mass_assignment_of :title

  context "validations" do
    setup do
      a = Factory(:album)
    end

    should validate_presence_of :title
    should validate_uniqueness_of :title
  end

  should "order by position and allow rearrangement" do
    a1 = Factory(:album)
    a2 = Factory(:album)

    assert_equal [a1, a2], Album.ordered

    a2.move_higher
    a1.reload

    assert_equal [a2, a1], Album.ordered
  end

  should "order associated images by position" do
    a = Factory(:album)
    ai1 = Factory(:album_image, :album => a)
    ai2 = Factory(:album_image, :album => a)
    ai2.move_higher
    ai1.reload

    assert_equal [ai2, ai1], a.album_images
    assert_equal [ai2.image, ai1.image], a.images
  end
end
