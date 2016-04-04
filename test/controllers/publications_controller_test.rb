require 'test_helper'

class PublicationsControllerTest < ActionController::TestCase
  setup do
    @publication = publications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:publications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create publication" do
    assert_difference('Publication.count') do
      post :create, publication: { ano_periodo: @publication.ano_periodo, arbitr_no_arbitr: @publication.arbitr_no_arbitr, creador: @publication.creador, descripcion: @publication.descripcion, fecha_f: @publication.fecha_f, fecha_i: @publication.fecha_i, horas: @publication.horas, revista_editorial: @publication.revista_editorial, titulo: @publication.titulo }
    end

    assert_redirected_to publication_path(assigns(:publication))
  end

  test "should show publication" do
    get :show, id: @publication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @publication
    assert_response :success
  end

  test "should update publication" do
    patch :update, id: @publication, publication: { ano_periodo: @publication.ano_periodo, arbitr_no_arbitr: @publication.arbitr_no_arbitr, creador: @publication.creador, descripcion: @publication.descripcion, fecha_f: @publication.fecha_f, fecha_i: @publication.fecha_i, horas: @publication.horas, revista_editorial: @publication.revista_editorial, titulo: @publication.titulo }
    assert_redirected_to publication_path(assigns(:publication))
  end

  test "should destroy publication" do
    assert_difference('Publication.count', -1) do
      delete :destroy, id: @publication
    end

    assert_redirected_to publications_path
  end
end
