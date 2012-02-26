Factory.define :image do |f|
  include ActionDispatch::TestProcess
  f.title "Test Image"
  f.image { fixture_file_upload('test/fixtures/sample_image.jpg', 'image/jpeg') }
end
