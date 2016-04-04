require 'test_helper'

class ExtensionsControllerTest < ActionController::TestCase
  setup do
    @extension = extensions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extensions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extension" do
    assert_difference('Extension.count') do
      post :create, extension: { ano_periodo: @extension.ano_periodo, creador: @extension.creador, descripcion: @extension.descripcion, fecha_f: @extension.fecha_f, fecha_i: @extension.fecha_i, horas: @extension.horas, nombre: @extension.nombre, tipo: @extension.tipo }
    end

    assert_redirected_to extension_path(assigns(:extension))
  end

  test "should show extension" do
    get :show, id: @extension
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extension
    assert_response :success
  end

  test "should update extension" do
    patch :update, id: @extension, extension: { ano_periodo: @extension.ano_periodo, creador: @extension.creador, descripcion: @extension.descripcion, fecha_f: @extension.fecha_f, fecha_i: @extension.fecha_i, horas: @extension.horas, nombre: @extension.nombre, tipo: @extension.tipo }
    assert_redirected_to extension_path(assigns(:extension))
  end

  test "should destroy extension" do
    assert_difference('Extension.count', -1) do
      delete :destroy, id: @extension
    end

    assert_redirected_to extensions_path
  end
end
