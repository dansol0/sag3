class CoferencesController < ApplicationController

  before_action :set_coference, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /coferences
  # GET /coferences.json

  def menu_gestion_extension_conferencia_o_ponencia
   periodo = Period.where(estatus: 'Activo').take
        
  @coferences = Coference.joins(:users).where(users: {id: current_user.id}).where(ano_periodo: periodo).order(fecha_i: :desc)
   @coferences2 = @coferences
   @resultados = @coferences.count
     @coferences =  @coferences.page(params[:page])
   
    respond_to do |format|
        format.html
        format.pdf do
          pdf = CoferenceindexPdf.new(@coferences2, view_context)
         send_data  pdf.render, filename: "Lista de Conferencia o ponencias.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  def buscar_menu
    
  end

  def buscar_coference
    
  end

  def buscar_titulo_coference
    
  end

  def buscar_fechas_coference
    
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
           @user_id =params[:user_ids].to_i
           @coferences = Coference.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
        when 2
             @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @coferences = Coference.joins(:users).search(params[:search]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                       @coferences = Coference.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                  else
                      @coferences = Coference.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                  end
              end
        when 3
            @ano_periodo=params[:ano_periodo]
                    @tipo=params[:tipo]
                 
              if current_user.rol == "administrador"
                   
                        if !params[:tipo].blank?
                        @coferences = Coference.joins(:users).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                       else
                           @coferences = Coference.joins(:users).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                    
              else
                  if current_user.rol == "Jefe de Departamento"
                        
                            if !params[:tipo].blank?
                            @coferences = Coference.joins(:users).where(users: {rol: 'investigador'}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @coferences = Coference.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                      
                  else
                        
                            if !params[:tipo].blank?
                            @coferences = Coference.joins(:users).where(users: {id: current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @coferences = Coference.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  end
              end
        else#opcion 4
                 @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @coferences = Coference.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                    @coferences = Coference.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  else
                      @coferences = Coference.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

     @coferences2 = @coferences
   @resultados = @coferences.count
     @coferences =  @coferences.page(params[:page])

        respond_to do |format|
        format.html
        format.pdf do
          pdf = CoferenceindexPdf.new(@coferences2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de Conferencia o ponencias.pdf",type: "application/pdf", disposition: "inline"
       end
     end
    
  end

  # GET /coferences/1
  # GET /coferences/1.json
  def show 
  
    @user = User.all#para la lista de checkbox
    @userr = User.find(@coference.creador)#para ver el nombre del creador
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CoferenceshowPdf.new(@coference, view_context, @userr)
       send_data  pdf.render, filename: "coference_#{@coference.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
     
  end

  

  def show2
  
    @user = User.all
    @userr = User.find(@coference.creador)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CoferenceshowPdf.new(@coference, view_context, @userr)
       send_data  pdf.render, filename: "coference_#{@coference.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
     
  end




  # GET /coferences/new
  def new
    @coference = Coference.new
   
  end

  # GET /coferences/1/edit
  def edit
    #@users = User.where.not(id: current_user.id).order(nombre1: :asc)
    @users = User.all.order(nombre1: :asc)
  end

  # POST /coferences
  # POST /coferences.json
  def create
 
   @coference = Coference.new(coference_params)

   @user = User.find(session[:user_id]) 
   respond_to do |format|
        if @coference.save
           @user.coferences << @coference
          format.html { redirect_to @coference, notice: 'La actividad se registro con exito.' }
          format.json { render :show, status: :created, location: @coference }
        else
          format.html { render :new }
          format.json { render json: @coference.errors, status: :unprocessable_entity }
        end
      end
   
  end



  # PATCH/PUT /coferences/1
  # PATCH/PUT /coferences/1.json
  def update
   @users = User.all.order(nombre1: :asc)
   if params[:coference][:user_ids]
      params[:coference][:user_ids] = params[:coference][:user_ids].map{|k, v| k}
    else
      params[:coference][:user_ids] = []
    end

    respond_to do |format|
      if @coference.update(coference_params)
        format.html { redirect_to @coference, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @coference }
      else
        format.html { render :edit }
        format.json { render json: @coference.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /coferences/1
  # DELETE /coferences/1.json
  def destroy

    @coference.destroy
    respond_to do |format|
      format.html { redirect_to menu_extension_1_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coference
      @coference = Coference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coference_params
      params.require(:coference).permit(:tipo, :titulo, :evento, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, user_ids: [])
    end

end
