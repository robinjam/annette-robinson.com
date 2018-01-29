require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  setup do
    @image = images(:one)
    log_in
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image" do
    assert_difference('Image.count') do
      post :create, params: { image: { title: "Image 3", image: fixture_file_upload('/files/sample_image.jpg', 'image/jpeg') } }
    end

    assert_redirected_to images_path
  end

  test "should get edit" do
    get :edit, params: { id: @image }
    assert_response :success
  end

  test "should update image" do
    # Attach a file to the image so the update succeeds
    @image.update_attributes!(image: fixture_file_upload('/files/sample_image.jpg', 'image/jpeg'))

    put :update, params: { id: @image, image: { title: @image.title } }
    assert_redirected_to images_path
  end

  test "should get delete" do
    get :delete, params: { id: @image }
    assert_response :success
  end

  test "should destroy image" do
    assert_difference('Image.count', -1) do
      delete :destroy, params: { id: @image }
    end

    assert_redirected_to images_path
  end
end
