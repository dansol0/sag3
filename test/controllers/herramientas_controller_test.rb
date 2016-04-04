require 'test_helper'

class HerramientasControllerTest < ActionController::TestCase
  test "should get graficos" do
    get :graficos
    assert_response :success
  end

  test "should get reportes" do
    get :reportes
    assert_response :success
  end

  test "should get estadisticas" do
    get :estadisticas
    assert_response :success
  end

  test "should get tablas" do
    get :tablas
    assert_response :success
  end

end
