require 'test_helper'

class AlbumImagesControllerTest < ActionController::TestCase
  setup do
    @album_image = album_images(:two)
    log_in
  end

  test "should redirect on get to new with no additional images" do
    get :new, album_id: @album_image.album
    assert_redirected_to album_path(@album_image.album)
  end

  test "should get new" do
    get :new, album_id: album_images(:one).album
    assert_response :success
  end

  test "should create album_image" do
    @album_image = album_images(:one)

    assert_difference('AlbumImage.count') do
      post :create, album_id: @album_image.album, album_image: { image_id: images(:two) }
    end

    assert_redirected_to album_path(@album_image.album)
  end

  test "should destroy album_image" do
    assert_difference('AlbumImage.count', -1) do
      delete :destroy, album_id: @album_image.album, id: @album_image
    end

    assert_redirected_to album_path(@album_image.album)
  end

  test "should move album_image" do
    assert_difference('@album_image.position', -1) do
      post :move, album_id: @album_image.album, id: @album_image.image, to: 1, format: 'json'
      @album_image.reload
    end

    assert_response :success
  end
end
