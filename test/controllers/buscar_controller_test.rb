require 'test_helper'

class BuscarControllerTest < ActionController::TestCase
  test "should get area" do
    get :area
    assert_response :success
  end

  test "should get fecha" do
    get :fecha
    assert_response :success
  end

  test "should get investigador" do
    get :investigador
    assert_response :success
  end

end
