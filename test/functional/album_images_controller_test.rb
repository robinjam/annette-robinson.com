require 'test_helper'

class AlbumImagesControllerTest < ActionController::TestCase
  setup do
    @album_image = Factory(:album_image)
    log_in
  end

  test "should get new" do
    Factory(:image) #TODO: Add additional test without this
    get :new, :album_id => @album_image.album.to_param
    assert_response :success
  end

  test "should create album image" do
    assert_difference('AlbumImage.count') do
      album_id = @album_image.album.to_param
      image_id = Factory(:image).to_param
      post :create, :album_id => album_id, :album_image => { :image_id => image_id }
    end

    assert_redirected_to @album_image.album
  end

  test "should destroy album image" do
    assert_difference('AlbumImage.count', -1) do
      delete :destroy, :album_id => @album_image.album.to_param, :id => @album_image.image.to_param
    end

    assert_redirected_to album_path(@album_image.album.to_param)
  end

  test "should promote album image" do
    @album_image_two = Factory(:album_image, :album => @album_image.album)
    assert_difference('@album_image_two.position', -1) do
      post :promote, :album_id => @album_image_two.album.to_param, :id => @album_image_two.to_param
      @album_image_two.reload
    end

    assert_redirected_to @album_image_two.album
  end

  test "should demote album image" do
    @album_image_two = Factory(:album_image, :album => @album_image.album)
    assert_difference('@album_image.position') do
      post :demote, :album_id => @album_image.album.to_param, :id => @album_image.to_param
      @album_image.reload
    end

    assert_redirected_to @album_image.album
  end
end
