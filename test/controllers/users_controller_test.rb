require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { adscrito: @user.adscrito, anos_serv: @user.anos_serv, apellido1: @user.apellido1, apellido2: @user.apellido2, area: @user.area, cargo: @user.cargo, categoria_actual: @user.categoria_actual, cedula: @user.cedula, dedicacion: @user.dedicacion, direccion: @user.direccion, email: @user.email, fecha_ult_ascenso: @user.fecha_ult_ascenso, grado_academico: @user.grado_academico, nombre1: @user.nombre1, nombre2: @user.nombre2, password: @user.password, rol: @user.rol, tlf: @user.tlf }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { adscrito: @user.adscrito, anos_serv: @user.anos_serv, apellido1: @user.apellido1, apellido2: @user.apellido2, area: @user.area, cargo: @user.cargo, categoria_actual: @user.categoria_actual, cedula: @user.cedula, dedicacion: @user.dedicacion, direccion: @user.direccion, email: @user.email, fecha_ult_ascenso: @user.fecha_ult_ascenso, grado_academico: @user.grado_academico, nombre1: @user.nombre1, nombre2: @user.nombre2, password: @user.password, rol: @user.rol, tlf: @user.tlf }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
