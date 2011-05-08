require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  should allow_mass_assignment_of :title
  should_not allow_mass_assignment_of :position

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
end
