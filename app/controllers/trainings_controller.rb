class TrainingsController < ApplicationController
  before_action :set_training, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /trainings
  # GET /trainings.json
  def menu_gestion_mejoramiento_y_capacitacion
periodo = Period.where(estatus: 'Activo').take
      
   @trainings = Training.joins(:users).where(users: {id: current_user.id}).where( ano_periodo: periodo).order(fecha_i: :desc)
 
 @trainings2 = @trainings
     @resultados = @trainings.count
     @trainings =  @trainings.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = TrainingindexPdf.new(@trainings2, view_context)
         send_data  pdf.render, filename: "Lista de actividades de mejoramiento y capacitacón.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  def buscar_menu
    
  end

  def buscar_training
    
      
  end

  def buscar_titulo_training
    
  end

  def buscar_fechas_training
    
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
           @trainings = Training.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
        when 2
             @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @trainings = Training.joins(:users).search(params[:search]).order(fecha_i: :desc)
               else
                  if current_user.rol == "Jefe de Departamento"
                       @trainings = Training.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                   else
                      @trainings = Training.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                  end
              end
        when 3
              @ano_periodo=params[:ano_periodo]
                    @tipo=params[:tipo]
              if current_user.rol == "administrador"
                    
                        if !params[:tipo].blank?
                        @trainings = Training.joins(:users).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                        else
                           @trainings = Training.joins(:users).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                    
              else
                  if current_user.rol == "Jefe de Departamento"
                       
                            if !params[:tipo].blank?
                            @trainings = Training.joins(:users).where(users: {rol: 'investigador'}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @trainings = Training.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                             end
                        
                  else
                       
                            if !params[:tipo].blank?
                            @trainings = Training.joins(:users).where(users: {id: current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @trainings = Training.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  end
              end
        else#opcion 4
               @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @trainings = Training.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                    @trainings = Training.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  else
                      @trainings = Training.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

      @trainings2 = @trainings
     @resultados = @trainings.count
     @trainings =  @trainings.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = TrainingindexPdf.new(@trainings2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de actividades de mejoramiento y capacitacón.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  # GET /trainings/1
  # GET /trainings/1.json
  def show
    @user = User.all
    @userr = User.find(@training.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = TrainingshowPdf.new(@training, view_context, @userr)
       send_data  pdf.render, filename: "training_#{@training.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
     
  end

  def show2
    @user = User.all
    @userr = User.find(@training.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = TrainingshowPdf.new(@training, view_context, @userr)
       send_data  pdf.render, filename: "training_#{@training.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
     
  end

  # GET /trainings/new
  def new
    @training = Training.new
    
  end

  # GET /trainings/1/edit
  def edit
 @users = User.all.order(nombre1: :asc)
     
  end

  # POST /trainings
  # POST /trainings.json
  def create


    @training = Training.new(training_params)
    @user = User.find(session[:user_id]) 
   
    respond_to do |format|
      if @training.save
        @user.trainings << @training
        format.html { redirect_to @training, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /trainings/1
  # PATCH/PUT /trainings/1.json
  def update
@users = User.all.order(nombre1: :asc)
    if params[:training][:user_ids]
      params[:training][:user_ids] = params[:training][:user_ids].map{|k, v| k}
    else
      params[:training][:user_ids] = []
    end
    
    respond_to do |format|
      if @training.update(training_params)
        format.html { redirect_to @training, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @training }
      else
        format.html { render :edit }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end

     
  end

  # DELETE /trainings/1
  # DELETE /trainings/1.json
  def destroy
    @training.destroy
    respond_to do |format|
      format.html { redirect_to menu_docencia_2_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_params
      params.require(:training).permit(:tipo, :nombre,  :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, user_ids: [])
    end
end
