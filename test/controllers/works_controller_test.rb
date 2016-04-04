require 'test_helper'

class WorksControllerTest < ActionController::TestCase
  setup do
    @work = works(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work" do
    assert_difference('Work.count') do
      post :create, work: { ano_periodo: @work.ano_periodo, autores: @work.autores, creador: @work.creador, descripcion: @work.descripcion, fecha_f: @work.fecha_f, fecha_i: @work.fecha_i, horas: @work.horas, tipo: @work.tipo, titulo: @work.titulo }
    end

    assert_redirected_to work_path(assigns(:work))
  end

  test "should show work" do
    get :show, id: @work
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work
    assert_response :success
  end

  test "should update work" do
    patch :update, id: @work, work: { ano_periodo: @work.ano_periodo, autores: @work.autores, creador: @work.creador, descripcion: @work.descripcion, fecha_f: @work.fecha_f, fecha_i: @work.fecha_i, horas: @work.horas, tipo: @work.tipo, titulo: @work.titulo }
    assert_redirected_to work_path(assigns(:work))
  end

  test "should destroy work" do
    assert_difference('Work.count', -1) do
      delete :destroy, id: @work
    end

    assert_redirected_to works_path
  end
end
