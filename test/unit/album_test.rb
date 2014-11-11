require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  def setup
    @album = albums(:one)
  end

  test "to_param" do
    assert_equal "#{@album.id}-album-1", @album.to_param
  end

  test "find by param" do
    assert_equal @album, Album.find(@album.to_param)
  end

  test "images_not_present" do
    assert_equal [images(:two)], @album.images_not_present
  end
end
