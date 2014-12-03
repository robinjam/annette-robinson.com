require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @album = albums(:one)
    Image.all.each { |img| img.update!(image: fixture_file_upload('sample_image.jpg', 'image/jpeg')) }
    log_in
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create album" do
    assert_difference('Album.count') do
      post :create, album: { title: "Album 3" }
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should show first album when ID not specified" do
    get :show
    assert_response :success
    assert_equal albums(:two), assigns(:album)

    albums(:one).move_higher

    get :show
    assert_response :success
    assert_equal albums(:one), assigns(:album)
  end

  test "should show album" do
    get :show, id: @album
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @album
    assert_response :success
  end

  test "should update album" do
    put :update, id: @album, album: { title: @album.title }
    assert_redirected_to album_path(assigns(:album))
  end

  test "should get delete" do
    get :delete, id: @album
    assert_response :success
  end

  test "should destroy album" do
    assert_difference('Album.count', -1) do
      delete :destroy, id: @album
    end

    assert_redirected_to root_path
  end

  test "should move album" do
    assert_difference('@album.position', -1) do
      post :move, id: @album, to: 1, format: 'json'
      @album.reload
    end

    assert_response :success
  end
end
