require 'test_helper'

class CoferencesControllerTest < ActionController::TestCase
  setup do
    @coference = coferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coference" do
    assert_difference('Coference.count') do
      post :create, coference: { ano_periodo: @coference.ano_periodo, creador: @coference.creador, descripcion: @coference.descripcion, evento: @coference.evento, fecha_f: @coference.fecha_f, fecha_i: @coference.fecha_i, horas: @coference.horas, tipo: @coference.tipo, titulo: @coference.titulo }
    end

    assert_redirected_to coference_path(assigns(:coference))
  end

  test "should show coference" do
    get :show, id: @coference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coference
    assert_response :success
  end

  test "should update coference" do
    patch :update, id: @coference, coference: { ano_periodo: @coference.ano_periodo, creador: @coference.creador, descripcion: @coference.descripcion, evento: @coference.evento, fecha_f: @coference.fecha_f, fecha_i: @coference.fecha_i, horas: @coference.horas, tipo: @coference.tipo, titulo: @coference.titulo }
    assert_redirected_to coference_path(assigns(:coference))
  end

  test "should destroy coference" do
    assert_difference('Coference.count', -1) do
      delete :destroy, id: @coference
    end

    assert_redirected_to coferences_path
  end
end
