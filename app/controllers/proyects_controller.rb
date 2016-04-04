class ProyectsController < ApplicationController
  before_action :set_proyect, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /proyects
  # GET /proyects.json

  def tabla_investigaciones_de_grupo_en_espera
    periodo = Period.where(estatus: 'Activo').take
     @proyects = Proyect.where(grupo_o_individual: 'Grupo', ano_periodo: periodo, estatus: 'En Espera de Aprobación').order(fecha_i: :desc)
    @cantidad_de_grupo = @proyects.count
  @proyects_de_grupo2 =  @proyects.page(params[:page])
    contador= 0

    @proyects.each do |proyect|
    @user= User.find(proyect.investigador_responsable).nombre_apellido
    proyect.investigador_responsable=  @user
   end 

       respond_to do |format|
        format.html
        format.pdf do
          pdf = TablaInvestigacionesDeGrupoEnEsperaPdf.new(@proyects, view_context)
         send_data  pdf.render, filename: "Investigaciones de grupo en espera por aprobación.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

 def  tabla_investigaciones_individual_en_espera
        periodo = Period.where(estatus: 'Activo').take
   @proyects = Proyect.where(grupo_o_individual: 'Individual', ano_periodo: periodo, estatus: 'En Espera de Aprobación').order(fecha_i: :desc)
    @cantidad_individual = @proyects.count
    @proyects_individual2 =  @proyects.page(params[:page])
    contador= 0

   @proyects.each do |proyect|
    @user= User.find(proyect.investigador_responsable).nombre_apellido
    proyect.investigador_responsable=  @user
   end 
     respond_to do |format|
        format.html
        format.pdf do
          pdf = TablaInvestigacionesIndividualEnEsperaPdf.new(@proyects, view_context)
         send_data  pdf.render, filename: "Investigaciones individuales en espera por aprobación.pdf",type: "application/pdf", disposition: "inline"
       end
     end

  end

  def tabla_investigaciones_de_grupo_culminados
        periodo = Period.where(estatus: 'Activo').take
     @proyects = Proyect.where(grupo_o_individual: 'Grupo', ano_periodo: periodo, estatus: 'Culminado').order(fecha_i: :desc)
     @cantidad_de_grupo = @proyects.count
    @proyects_de_grupo2 =  @proyects.page(params[:page])
    contador= 0

   @proyects.each do |proyect|
    @user= User.find(proyect.investigador_responsable).nombre_apellido
    proyect.investigador_responsable=  @user
   end 

       respond_to do |format|
        format.html
        format.pdf do
          pdf = TablaInvestigacionesDeGrupoCulminadosPdf.new(@proyects, view_context)
         send_data  pdf.render, filename: "Investigaciones de grupo culminados.pdf",type: "application/pdf", disposition: "inline"
       end
     end
    end

  def tabla_investigaciones_individual_culminados
        periodo = Period.where(estatus: 'Activo').take
   @proyects = Proyect.where(grupo_o_individual: 'Individual', ano_periodo: periodo, estatus: 'Culminado').order(fecha_i: :desc)
    @cantidad_individual = @proyects.count
    @proyects_individual2 =  @proyects.page(params[:page])
    contador= 0

   @proyects.each do |proyect|
    @user= User.find(proyect.investigador_responsable).nombre_apellido
    proyect.investigador_responsable=  @user
   end 
     respond_to do |format|
        format.html
        format.pdf do
          pdf = TablaInvestigacionesIndividualCulminadasPdf.new(@proyects, view_context)
         send_data  pdf.render, filename: "Investigaciones individuales culminados.pdf",type: "application/pdf", disposition: "inline"
       end
     end

    end

  def tabla_resumen_totalizador_de_investigaciones
    periodo = Period.where(estatus: 'Activo').take
     @proyects_de_grupo = Proyect.where(grupo_o_individual: 'Grupo', ano_periodo: periodo).order(fecha_i: :desc)
     @proyects_individual = Proyect.where(grupo_o_individual: 'Individual', ano_periodo: periodo).order(fecha_i: :desc)
     
     @cantidad_de_grupo = @proyects_de_grupo.count
     @cantidad_individual = @proyects_individual.count

     @resultados = @cantidad_de_grupo + @cantidad_individual

       respond_to do |format|
        format.html
        format.pdf do
          pdf = ResumenTotalizadorDeInvestigacionesPdf.new(@cantidad_de_grupo, @cantidad_individual, view_context)
         send_data  pdf.render, filename: "Resumen totalizador de investigaciones.pdf",type: "application/pdf", disposition: "inline"
       end
     end

  end

  def tabla_investigaciones_de_grupo
    periodo = Period.where(estatus: 'Activo').take
   @proyects = Proyect.where(grupo_o_individual: 'Grupo', ano_periodo: periodo, estatus: 'En desarrollo').order(fecha_i: :desc)
    @cantidad_de_grupo = @proyects.count
    @proyects_de_grupo2 =  @proyects.page(params[:page])
    contador= 0

   @proyects.each do |proyect|
    @user= User.find(proyect.investigador_responsable).nombre_apellido
    proyect.investigador_responsable=  @user
   end 
     respond_to do |format|
        format.html
        format.pdf do
          pdf = TablaInvestigacionesDeGrupoPdf.new(@proyects, view_context)
         send_data  pdf.render, filename: "Investigaciones de grupo en desarrollo.pdf",type: "application/pdf", disposition: "inline"
       end
     end

  end

  def tabla_investigaciones_individual
    periodo = Period.where(estatus: 'Activo').take
    @proyects = Proyect.where(grupo_o_individual: 'Individual', ano_periodo: periodo, estatus: 'En desarrollo').order(fecha_i: :desc)
    @cantidad_individual = @proyects.count
     @proyects_individual2 =  @proyects.page(params[:page])
       contador= 0

   @proyects.each do |proyect|
    @user= User.find(proyect.investigador_responsable).nombre_apellido
    proyect.investigador_responsable=  @user
   end
     respond_to do |format|
        format.html
        format.pdf do
          pdf = TablaInvestigacionesIndividualPdf.new(@proyects, view_context)
         send_data  pdf.render, filename: "tabla investigaciones individuales en desarrollo.pdf",type: "application/pdf", disposition: "inline"
       end
     end
    
  end

  


  def menu_gestion_investigacion_proyecto
     @proyects = Proyect.joins(:users).where(users: {id: current_user.id}).where(ano_periodo: Time.now.year).order(fecha_i: :desc)
      @proyects2 = @proyects
     @resultados = @proyects.count
     @proyects =  @proyects.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = ProyectindexPdf.new(@proyects2, view_context)
         send_data  pdf.render, filename: "Lista de proyectos del área de investigación.pdf",type: "application/pdf", disposition: "inline"
       end
     end

  end

  def buscar_menu
    
  end

  def buscar_proyect
    
  end

  def buscar_titulo_proyect
    
  end

  def buscar_fechas_proyect
    
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

            case @opcion
              when 1 
                @opc = params[:opc].to_i
                @user_id =params[:user_ids].to_i
                case @opc
                  when 0
                      @proyects = Proyect.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
                  when 1
                      @proyects = Proyect.where("investigador_responsable = ?", params[:user_ids] ).order(fecha_i: :desc)
                  else
                      @proyects = Proyect.where("co_investigador = ?", params[:user_ids] ).order(fecha_i: :desc)
                  end
              when 2
                @search = params[:search].to_s
                   if current_user.rol == "administrador"
                       @proyects = Proyect.joins(:users).search(params[:search]).order(fecha_i: :desc)
                    else
                        if current_user.rol == "Jefe de Departamento"
                             @proyects = Proyect.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                        else
                            @proyects = Proyect.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                        end
                    end
              when 3
                 
                    @ano_periodo=params[:ano_periodo]
                    @estatus=params[:estatus]
                 
                      if current_user.rol == "administrador"
                           
                                if !params[:estatus].blank?
                                @proyects = Proyect.where("estatus = ? AND ano_periodo = ?" , params[:estatus],params[:ano_periodo] ).order(fecha_i: :desc)
                               else
                                   @proyects = Proyect.where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                                end
                            
                      else
                          if current_user.rol == "Jefe de Departamento"
                                
                                    if !params[:estatus].blank?
                                    @proyects = Proyect.joins(:users).where(users: {rol: 'investigador'}).where("estatus = ? AND ano_periodo = ?" , params[:estatus],params[:ano_periodo]).order(fecha_i: :desc)
                                   else
                                       @proyects = Proyect.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                                    end
                                
                          else
                                
                                    if !params[:estatus].blank?
                                    @proyects = Proyect.joins(:users).where(users: {id: current_user.id}).where("estatus = ? AND ano_periodo = ?" , params[:estatus],params[:ano_periodo]).order(fecha_i: :desc)
                                    else
                                       @proyects = Proyect.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                                    end
                                
                          end
                      end

               else#opcion 4

                    @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
                     if current_user.rol == "administrador"
                      @proyects = Proyect.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                    else
                        if current_user.rol == "Jefe de Departamento"
                          @proyects = Proyect.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                        else
                            @proyects = Proyect.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                        end
                    end
              
                   
              end

            #@resultados = @proyects.count
           # @proyects2 =  @proyects.page(params[:page])
       
    
     respond_to do |format|
        format.html
        format.pdf do
          pdf = ProyectindexPdf.new(@proyects, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de proyectos del área de investigación.pdf",type: "application/pdf", disposition: "inline"
       end
     end
    
  end

  # GET /proyects/1
  # GET /proyects/1.json
  def show
    @user = User.all
    @userr = User.find(@proyect.creador)
    @userr2 = User.find(@proyect.investigador_responsable)
    @userr3 = User.find(@proyect.co_investigador)
     respond_to do |format|
      format.html
      format.pdf do
        pdf = ProyectshowPdf.new(@proyect, view_context,@userr, @userr2, @userr3)
       send_data  pdf.render, filename: "proyect_#{@proyect.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
  end

  def show2
    @user = User.all
    @userr = User.find(@proyect.creador)
    @userr2 = User.find(@proyect.investigador_responsable)
    @userr3 = User.find(@proyect.co_investigador)
     respond_to do |format|
      format.html
      format.pdf do
        pdf = ProyectshowPdf.new(@proyect, view_context,@userr, @userr2, @userr3)
       send_data  pdf.render, filename: "proyect_#{@proyect.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
  end

  # GET /proyects/new
  def new
    @proyect = Proyect.new
    @users = User.all
     
  end

  # GET /proyects/1/edit
  def edit
 
    @users = User.all.order(nombre1: :asc)
  end

  # POST /proyects
  # POST /proyects.json
  def create

    @proyect = Proyect.new(proyect_params)
  @user = User.find(session[:user_id]) 
    respond_to do |format|
      if @proyect.save
          @user.proyects << @proyect
        format.html { redirect_to @proyect, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @proyect }
      else
        format.html { render :new }
        format.json { render json: @proyect.errors, status: :unprocessable_entity }
      end
    end

    
  end

  # PATCH/PUT /proyects/1
  # PATCH/PUT /proyects/1.json
  def update
@users = User.all.order(nombre1: :asc)
    if params[:proyect][:user_ids]
      params[:proyect][:user_ids] = params[:proyect][:user_ids].map{|k, v| k}
    else
      params[:proyect][:user_ids] = []
    end
    
    respond_to do |format|
      if @proyect.update(proyect_params)
        format.html { redirect_to @proyect, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @proyect }
      else
        format.html { render :edit }
        format.json { render json: @proyect.errors, status: :unprocessable_entity }
      end
    end

    
  end

  # DELETE /proyects/1
  # DELETE /proyects/1.json
  def destroy
    @proyect.destroy
    respond_to do |format|
      format.html { redirect_to menu_investigacion_1_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proyect
      @proyect = Proyect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proyect_params
      params.require(:proyect).permit(:titulo, :estatus, :ente_financista, :integrantes, :monto, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, :investigador_responsable, :co_investigador, :grupo_o_individual, user_ids: [])
    end
end
