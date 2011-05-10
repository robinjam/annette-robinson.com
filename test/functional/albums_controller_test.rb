require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @album = Factory(:album)
    log_in
  end

  test "should get first album" do
    get :first
    assert_redirected_to album_url(Album.first)
  end

  test "should render welcome page when there are no albums" do
    @album.destroy
    get :first
    assert_response :success
    assert_template 'first'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create album" do
    assert_difference('Album.count') do
      post :create, :album => Factory.attributes_for(:album)
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should show album" do
    get :show, :id => @album.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @album.to_param
    assert_response :success
  end

  test "should update album" do
    put :update, :id => @album.to_param, :album => @album.attributes
    assert_redirected_to album_path(assigns(:album))
  end

  test "should get delete" do
    get :delete, :id => @album.to_param
    assert_response :success
  end

  test "should destroy album" do
    assert_difference('Album.count', -1) do
      delete :destroy, :id => @album.to_param
    end

    assert_redirected_to root_path
  end

  test "should promote album" do
    @album_two = Factory(:album)
    assert_difference('@album_two.position', -1) do
      post :promote, :id => @album_two.to_param
      @album_two.reload
    end

    assert_redirected_to @album_two
  end

  test "should demote album" do
    @album_two = Factory(:album)
    assert_difference('@album.position') do
      post :demote, :id => @album.to_param
      @album.reload
    end

    assert_redirected_to @album
  end

  test "should move album" do
    @album_two = Factory(:album)
    assert_difference('@album.position') do
      post :move, :id => @album_two.to_param, :to => 1
      @album.reload
    end

    assert_redirected_to @album_two
  end
end
