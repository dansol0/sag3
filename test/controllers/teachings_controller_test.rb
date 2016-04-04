require 'test_helper'

class TeachingsControllerTest < ActionController::TestCase
  setup do
    @teaching = teachings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teachings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teaching" do
    assert_difference('Teaching.count') do
      post :create, teaching: { ano_periodo: @teaching.ano_periodo, descripcion: @teaching.descripcion, fecha_f: @teaching.fecha_f, fecha_i: @teaching.fecha_i, horas: @teaching.horas, nombre: @teaching.nombre, tipo: @teaching.tipo, user: @teaching.user }
    end

    assert_redirected_to teaching_path(assigns(:teaching))
  end

  test "should show teaching" do
    get :show, id: @teaching
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teaching
    assert_response :success
  end

  test "should update teaching" do
    patch :update, id: @teaching, teaching: { ano_periodo: @teaching.ano_periodo, descripcion: @teaching.descripcion, fecha_f: @teaching.fecha_f, fecha_i: @teaching.fecha_i, horas: @teaching.horas, nombre: @teaching.nombre, tipo: @teaching.tipo, user: @teaching.user }
    assert_redirected_to teaching_path(assigns(:teaching))
  end

  test "should destroy teaching" do
    assert_difference('Teaching.count', -1) do
      delete :destroy, id: @teaching
    end

    assert_redirected_to teachings_path
  end
end
