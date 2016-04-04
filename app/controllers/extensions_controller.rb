class ExtensionsController < ApplicationController
  before_action :set_extension, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /extensions
  # GET /extensions.json


def tabla_extension_otra
      periodo = Period.where(estatus: 'Activo').take
  @opcion = params[:opcion].to_i
         
   
   case @opcion
   when 1
   @nombre = 'Comision u organización externa'
   @extensions = Extension.where(ano_periodo: periodo, tipo: 'Comision u organización externa').order(fecha_i: :desc)
   when 2
    @nombre = 'Redes'
    @extensions = Extension.where(ano_periodo: periodo, tipo: 'Redes').order(fecha_i: :desc)
    
  when 3
    @nombre = 'Proyectos de aplicación'
    @extensions = Extension.where(ano_periodo: periodo, tipo: 'Proyectos de aplicación').order(fecha_i: :desc)
  when 4
    @nombre = 'Asistencia a eventos nacionales o internacionales'
    @extensions = Extension.where(ano_periodo: periodo, tipo: 'Asistencia a evento').order(fecha_i: :desc)
  when 5
    @nombre = 'Divulgación y/o asistencias técnicas'
    @extensions = Extension.where(ano_periodo: periodo, tipo: 'Servivio de divulgación y/o asistencia técnica').order(fecha_i: :desc)
  when 6
    @nombre = 'Arbitrajes'
    @extensions = Extension.where(ano_periodo: periodo, tipo: 'Arbitraje').order(fecha_i: :desc)
  when 7
    @extensions = Extension.where(ano_periodo: periodo, tipo: 'Comités organizadores de eventos').order(fecha_i: :desc)
    @nombre = 'Comités organizadores de eventos'
    else
        
        @nombre = 'Otras actividades de extensión'
        @extensions = Extension.where(ano_periodo: periodo, tipo: 'Otras actividades de extensión').order(fecha_i: :desc)

    end
  


  @cantidad = @extensions.count
  @extensions2 =  @extensions.page(params[:page])

  @extensions.each do |extension|
      @user= User.find(extension.creador).nombre_apellido
      extension.descripcion=  @user
  end 


 

    respond_to do |format|
       format.html
       format.pdf do
         pdf = TablaExtensionOtraPdf.new(@extensions, @nombre, view_context)
         send_data  pdf.render, filename: "Lista de actividades de "+@nombre+".pdf",type: "application/pdf", disposition: "inline"
        end
     end
  
  end

 def menu_gestion_extension
  periodo = Period.where(estatus: 'Activo').take
      
    @extensions = Extension.joins(:users).where(users: {id: current_user.id}).where(ano_periodo: periodo).order(fecha_i: :desc)
     
     @extensions2 = @extensions
     @resultados = @extensions.count
     @extensions =  @extensions.page(params[:page])

      respond_to do |format|
        format.html
        format.pdf do
          pdf = ExtensionindexPdf.new(@extensions2, view_context)
         send_data  pdf.render, filename: "Lista de otras actividades del área de extensión.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  def buscar_menu
    
  end

  def buscar_extension
    
 
  end

  def buscar_titulo_extension
    
  end

  def buscar_fechas_extension
    
  end

  def buscar_investigador
    if current_user.rol == "administrador"
        #@users= User.all.where("id != ?", current_user.id)#todos los usuarios menos el
        @users= User.all.order(nombre1: :asc)
    else
        if current_user.rol == "Jefe de Departamento"
          @users= User.where(rol: 'investigador')#todos de rol investigador
          @users = @users + User.where(id: current_user.id).order(nombre1: :asc)
        else
         @users= User.where(id: current_user.id).order(nombre1: :asc)# solo se muestra el mismo
        end

     end
  end

  def index
          @opcion = params[:opcion].to_i
         case params[:opcion].to_i
        when 1 
           @extensions = Extension.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
        when 2
              @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @extensions = Extension.joins(:users).search(params[:search]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                       @extensions = Extension.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                  else
                      @extensions = Extension.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                  end
              end
        when 3

                    @ano_periodo=params[:ano_periodo]
                    @tipo=params[:tipo]
              if current_user.rol == "administrador"
                   
                        if !params[:tipo].blank?
                        @extensions = Extension.joins(:users).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                         else
                           @extensions = Extension.joins(:users).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                   
              else
                  if current_user.rol == "Jefe de Departamento"
                       
                            if !params[:tipo].blank?
                            @extensions = Extension.joins(:users).where(users: {rol: 'investigador'}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @extensions = Extension.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                       
                  else
                       
                            if !params[:tipo].blank?
                            @extensions = Extension.joins(:users).where(users: {id: current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @extensions = Extension.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                       
                  end
              end
        else#opcion 4
                @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @extensions = Extension.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
               else
                  if current_user.rol == "Jefe de Departamento"
                    @extensions = Extension.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                   else
                      @extensions = Extension.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

    @extensions2 = @extensions
     @resultados = @extensions.count
     @extensions =  @extensions.page(params[:page])

      respond_to do |format|
        format.html
        format.pdf do
         pdf = ExtensionindexPdf.new(@extensions2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de otras actividades del área de extensión.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  # GET /extensions/1
  # GET /extensions/1.json
  def show
      @user = User.all
    @userr = User.find(@extension.creador)
     respond_to do |format|
      format.html
      format.pdf do
        pdf = ExtensionshowPdf.new(@extension, view_context, @userr)
       send_data  pdf.render, filename: "extension_#{@extension.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
  end

  def show2
      @user = User.all
    @userr = User.find(@extension.creador)
     respond_to do |format|
      format.html
      format.pdf do
        pdf = ExtensionshowPdf.new(@extension, view_context, @userr)
       send_data  pdf.render, filename: "extension_#{@extension.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
  end

  # GET /extensions/new
  def new
    @extension = Extension.new
    
  end

  # GET /extensions/1/edit
  def edit
 @users = User.all.order(nombre1: :asc)
     
  end

  # POST /extensions
  # POST /extensions.json
  def create

    @extension = Extension.new(extension_params)
   @user = User.find(session[:user_id]) 
   
    respond_to do |format|
      if @extension.save
        @user.extensions << @extension
        format.html { redirect_to @extension, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @extension }
      else
        format.html { render :new }
        format.json { render json: @extension.errors, status: :unprocessable_entity }
      end
    end
  
  end

  # PATCH/PUT /extensions/1
  # PATCH/PUT /extensions/1.json
  def update
@users = User.all.order(nombre1: :asc)
    if params[:extension][:user_ids]
      params[:extension][:user_ids] = params[:extension][:user_ids].map{|k, v| k}
    else
      params[:extension][:user_ids] = []
    end
    
    respond_to do |format|
      if @extension.update(extension_params)
        format.html { redirect_to @extension, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @extension }
      else
        format.html { render :edit }
        format.json { render json: @extension.errors, status: :unprocessable_entity }
      end
    end
 
  end

  # DELETE /extensions/1
  # DELETE /extensions/1.json
  def destroy
    @extension.destroy
    respond_to do |format|
      format.html { redirect_to menu_extension_2_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extension
      @extension = Extension.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extension_params
      params.require(:extension).permit(:tipo, :nombre,  :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, user_ids: [])
    end
end
