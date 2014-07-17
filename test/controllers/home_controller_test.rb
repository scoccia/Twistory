require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get access" do
    get :access
    assert_response :success
  end

  test "should get mission" do
    get :mission
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
