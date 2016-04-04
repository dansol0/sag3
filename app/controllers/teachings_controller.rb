class TeachingsController < ApplicationController
  before_action :set_teaching, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /teachings
  # GET /teachings.json
  def menu_gestion_docencia
    periodo = Period.where(estatus: 'Activo').take
    
    @teachings = Teaching.joins(:users).where(users: {id: current_user.id}).where(ano_periodo: periodo).order(fecha_i: :desc)
     @teachings2 = @teachings
     @resultados = @teachings.count
     @teachings =  @teachings.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = TeachingindexPdf.new(@teachings2, view_context)
         send_data  pdf.render, filename: "Lista de otras actividades del área de docencia.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  def buscar_menu
    
  end

  def buscar_teaching
    
  end

  def buscar_titulo_teaching
    
  end

  def buscar_fechas_teaching
    
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
           @teachings = Teaching.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
        when 2
              @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @teachings = Teaching.joins(:users).search(params[:search]).order(fecha_i: :desc)
             else
                  if current_user.rol == "Jefe de Departamento"
                       @teachings = Teaching.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                  else
                      @teachings = Teaching.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                  end
              end
        when 3
              @ano_periodo=params[:ano_periodo]
                    @tipo=params[:tipo]
              if current_user.rol == "administrador"
                   
                        if !params[:tipo].blank?
                        @teachings = Teaching.joins(:users).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                       else
                           @teachings = Teaching.joins(:users).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                    
              else
                  if current_user.rol == "Jefe de Departamento"
                        
                            if !params[:tipo].blank?
                            @teachings = Teaching.joins(:users).where(users: {rol: 'investigador'}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @teachings = Teaching.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  else
                        
                            if !params[:tipo].blank?
                            @teachings = Teaching.joins(:users).where(users: {id: current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @teachings = Teaching.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  end
              end
        else#opcion 4
               @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @teachings = Teaching.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                    @teachings = Teaching.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  else
                      @teachings = Teaching.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

    @teachings2 = @teachings
     @resultados = @teachings.count
     @teachings =  @teachings.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = TeachingindexPdf.new(@teachings2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de otras actividades del área de docencia.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  # GET /teachings/1
  # GET /teachings/1.json
  def show
      @user = User.all
    @userr = User.find(@teaching.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = TeachingshowPdf.new(@teaching, view_context, @userr)
       send_data  pdf.render, filename: "teaching_#{@teaching.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
     
  end

  def show2
      @user = User.all
    @userr = User.find(@teaching.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = TeachingshowPdf.new(@teaching, view_context, @userr)
       send_data  pdf.render, filename: "teaching_#{@teaching.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
     
  end

  # GET /teachings/new
  def new
    @teaching = Teaching.new
    
  end

  # GET /teachings/1/edit
  def edit
 @users = User.all.order(nombre1: :asc)
     
  end

  # POST /teachings
  # POST /teachings.json
  def create

    @teaching = Teaching.new(teaching_params)
    @user = User.find(session[:user_id]) 
    
    respond_to do |format|
      if @teaching.save
        @user.teachings << @teaching
        format.html { redirect_to @teaching, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @teaching }
      else
        format.html { render :new }
        format.json { render json: @teaching.errors, status: :unprocessable_entity }
      end
    end

    
  end

  # PATCH/PUT /teachings/1
  # PATCH/PUT /teachings/1.json
  def update
@users = User.all.order(nombre1: :asc)
    if params[:teaching][:user_ids]
      params[:teaching][:user_ids] = params[:teaching][:user_ids].map{|k, v| k}
    else
      params[:teaching][:user_ids] = []
    end
    
    respond_to do |format|
      if @teaching.update(teaching_params)
        format.html { redirect_to @teaching, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @teaching }
      else
        format.html { render :edit }
        format.json { render json: @teaching.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /teachings/1
  # DELETE /teachings/1.json
  def destroy
    @teaching.destroy
    respond_to do |format|
      format.html { redirect_to menu_docencia_4_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teaching
      @teaching = Teaching.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teaching_params
      params.require(:teaching).permit(:tipo,  :nombre, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, user_ids: [])
    end
end
