class TutoringsController < ApplicationController
  before_action :set_tutoring, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /tutorings
  # GET /tutorings.json
  def menu_gestion_docencia_tutoria
    periodo = Period.where(estatus: 'Activo').take
        
    @tutorings = Tutoring.joins(:users).where(users: {id: current_user.id}).where( ano_periodo: periodo).order(fecha_i: :desc)
  @tutorings2 = @tutorings
     @resultados = @tutorings.count
     @tutorings =  @tutorings.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = TutoringindexPdf.new(@tutorings2, view_context)
         send_data  pdf.render, filename: "Lista de actividades de tutorias del área de docencia.pdf",type: "application/pdf", disposition: "inline"
       end
     end
   end

  def buscar_menu
    
  end

  def buscar_tutoring
    
 
  end

  def buscar_titulo_tutoring
    
  end

  def buscar_fechas_tutoring
    
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
           @tutorings = Tutoring.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
        when 2
             @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @tutorings = Tutoring.joins(:users).search(params[:search]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                       @tutorings = Tutoring.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                   else
                      @tutorings = Tutoring.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                  end
              end
        when 3

                    @ano_periodo=params[:ano_periodo]
                    @tipo=params[:tipo]
              if current_user.rol == "administrador"
                    
                        if !params[:tipo].blank?
                        @tutorings = Tutoring.joins(:users).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                       else
                           @tutorings = Tutoring.joins(:users).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                   
              else
                  if current_user.rol == "Jefe de Departamento"
                       
                            if !params[:tipo].blank?
                            @tutorings = Tutoring.joins(:users).where(users: {rol: 'investigador'}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @tutorings = Tutoring.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  else
                        
                            if !params[:tipo].blank?
                            @tutorings = Tutoring.joins(:users).where(users: {id: current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @tutorings = Tutoring.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  end
              end
        else#opcion 4
                @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @tutorings = Tutoring.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                    @tutorings = Tutoring.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  else
                      @tutorings = Tutoring.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

    @tutorings2 = @tutorings
     @resultados = @tutorings.count
     @tutorings =  @tutorings.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = TutoringindexPdf.new(@tutorings2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de actividades de tutorias del área de docencia.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  # GET /tutorings/1
  # GET /tutorings/1.json
  def show
    @user = User.all
    @userr = User.find(@tutoring.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = TutoringshowPdf.new(@tutoring, view_context, @userr)
       send_data  pdf.render, filename: "tutoring_#{@tutoring.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
    
  end

  def show2
    @user = User.all
    @userr = User.find(@tutoring.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = TutoringshowPdf.new(@tutoring, view_context, @userr)
       send_data  pdf.render, filename: "tutoring_#{@tutoring.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
    
  end

  # GET /tutorings/new
  def new
    @tutoring = Tutoring.new
     
  end

  # GET /tutorings/1/edit
  def edit
 @users = User.all.order(nombre1: :asc)
    
  end

  # POST /tutorings
  # POST /tutorings.json
  def create

    @tutoring = Tutoring.new(tutoring_params)
    @user = User.find(session[:user_id]) 
   
    respond_to do |format|
      if @tutoring.save
        @user.tutorings << @tutoring
        format.html { redirect_to @tutoring, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @tutoring }
      else
        format.html { render :new }
        format.json { render json: @tutoring.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /tutorings/1
  # PATCH/PUT /tutorings/1.json
  def update
@users = User.all.order(nombre1: :asc)
    if params[:tutoring][:user_ids]
      params[:tutoring][:user_ids] = params[:tutoring][:user_ids].map{|k, v| k}
    else
      params[:tutoring][:user_ids] = []
    end

    
    respond_to do |format|
      if @tutoring.update(tutoring_params)
        format.html { redirect_to @tutoring, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @tutoring }
      else
        format.html { render :edit }
        format.json { render json: @tutoring.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /tutorings/1
  # DELETE /tutorings/1.json
  def destroy
    @tutoring.destroy
    respond_to do |format|
      format.html { redirect_to tutorings_url, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutoring
      @tutoring = Tutoring.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutoring_params
      params.require(:tutoring).permit(:tipo,  :nombre, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, user_ids: [])
    end
end
