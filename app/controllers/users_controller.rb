class UsersController < ApplicationController


  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit2]
  before_filter :require_login
  
  # GET /users
  # GET /users.json
  def edit2
    
  end

  def seleccionar_usuario

      #@user= User.find(params[:user])
     @user = params[:user]
  end

  def cambiar_clave
  @user = User.find(params[:id].to_i)
   respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to usuarios_listar_path, notice: 'Se modificó la contraseña con exito.' }
          format.json { render :index, status: :ok, location: @user }
        else
          format.html { render :edit2 }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  
  end

  def tabla_profesores_ordinarios
    @numero= 0
    @users = User.all.order(nombre1: :asc)
    @users2 = @users
    @resultados = @users.count
    @users = @users.page(params[:page])

    respond_to do |format|
        format.html
        format.pdf do
          pdf = ProfesoresOrdinariosPdf.new(@users2, view_context)
          send_data  pdf.render, filename: "Profesores_Ordinarios.pdf",type: "application/pdf", disposition: "inline"
        end
    end
  end

  def tabla_jefe_de_departamento_del_idec
   @user1 = User.find_by rol: 'Jefe de Departamento', area: 'Área de Investigación'
   @user2 = User.find_by rol: 'Jefe de Departamento', area: 'Área de Docencia'
   @user3 = User.find_by rol: 'Jefe de Departamento', area: 'Área de Extensión'
   @user4 = User.find_by rol: 'Jefe de Departamento', area: 'Área de Estación Experimental'
   @user5 = User.find_by rol: 'Jefe de Departamento', area: 'Área de Asistencia Administrativa'
   if @user1.blank?
     @user1= User.new
      @user1.nombre1= "No se encontro ningun investigador con este cargo"
      @user1.apellido1=" "
    end
    if @user2.blank?
     @user2= User.new
      @user2.nombre1= "No se encontro ningun investigador con este cargo"
      @user2.apellido1=" "
    end
    if @user3.blank?
     @user3= User.new
      @user3.nombre1= "No se encontro ningun investigador con este cargo"
      @user3.apellido1=" "
    end
    if @user4.blank?
     @user4= User.new
      @user4.nombre1= "No se encontro ningun investigador con este cargo"
      @user4.apellido1=" "
    end
    if @user5.blank?
     @user5= User.new
      @user5.nombre1= "No se encontro ningun investigador con este cargo"
      @user5.apellido1=" "
    end
    respond_to do |format|
        format.html
        format.pdf do
          pdf = JefeDeDepartamentoPdf.new(@user1, @user2, @user3, @user4, @user5, view_context)
          send_data  pdf.render, filename: "Jefes_de_Departamento_del_IDEC.pdf",type: "application/pdf", disposition: "inline"
        end
    end

  end

  def index
    @users = User.all.order(nombre1: :asc)

    @users2 = @users.page(params[:page])
       respond_to do |format|
        format.html
        format.pdf do
          pdf = UserindexPdf.new(@users, view_context)
         send_data  pdf.render, filename: "Lista de investigadores.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit

    
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'El usuario ha sido creado con exito.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'El usuario ha sido actualizado con exito.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

   
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'El usuario ha sido eliminado con exito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :nombre1, :nombre2, :apellido1, :apellido2, :email, :direccion, :tlf, :rol, :password, :password_confirmation, :dedicacion, :cargo, :area, :categoria_actual, :anos_serv, :adscrito, :fecha_ult_ascenso, :grado_academico, :estatus_user)
    end
end
