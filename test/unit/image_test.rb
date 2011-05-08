require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  should allow_mass_assignment_of :title
  should allow_mass_assignment_of :image
  should_not allow_mass_assignment_of :image_file_name
  should_not allow_mass_assignment_of :image_content_type
  should_not allow_mass_assignment_of :image_file_size
  should_not allow_mass_assignment_of :image_updated_at
  
  should have_attached_file :image

  should validate_presence_of :title
  
  should validate_attachment_presence :image
  should validate_attachment_content_type(:image).
    allowing('image/jpeg', 'image/png').rejecting('text/plain')
  should validate_attachment_size(:image).less_than 10.megabytes
end
