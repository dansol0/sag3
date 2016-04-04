class ActivitiesController < ApplicationController
 
  before_action :set_activity, only: [:show2, :show, :edit, :update, :destroy]
  before_filter :require_login

  # GET /activities
  # GET /activities.json
#prawnto :prawn => { :top_margin => 75 }

 

  def menu_gestion_academico_administrativo
    periodo = Period.where(estatus: 'Activo').take
 
      @activities = Activity.where(user_id: current_user.id, ano_periodo: periodo).order(fecha_i: :desc)
       
    @activities2 = @activities
     @resultados = @activities.count
     @activities =  @activities.page(params[:page])

       respond_to do |format|
        format.html
        format.pdf do
          
          pdf = ActivityindexPdf.new(@activities2, view_context)
         send_data  pdf.render, filename: "Lista de actividades académico administrativas.pdf",type: "application/pdf", disposition: "inline"
            end
     end
  end

  def buscar_menu
    
  end

  def buscar_activity
   
  end

  def buscar_titulo_activity

  end

  def buscar_fechas_activity
   
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
           @activities = Activity.where("user_id = ?" ,params[:user_ids]).order(fecha_i: :desc)
        when 2
             @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @activities = Activity.joins(:user).search(params[:search]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                       @activities = Activity.joins(:user).where(:users => {:rol => "investigador"}).search(params[:search]).order(fecha_i: :desc)
                   else
                      @activities = Activity.joins(:user).where(:users => {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                  end
              end
        when 3
                @ano_periodo=params[:ano_periodo]
                     @tipo=params[:tipo]
              if current_user.rol == "administrador"
                   
                        if !params[:tipo].blank?
                        @activities = Activity.joins(:user).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                        else
                           @activities = Activity.joins(:user).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                    
              else

                  if current_user.rol == "Jefe de Departamento"
                        
                            if !params[:tipo].blank?
                            @activities = Activity.joins(:user).where(:users => {:rol => "investigador"}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                           else
                               @activities = Activity.joins(:user).where(:users => {:rol => "investigador"}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                           end
                        
                  else
                        
                            if !params[:tipo].blank?
                            @activities = Activity.joins(:user).where(:users => {:id => current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @activities = Activity.joins(:user).where(:users => {:id => current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                       
                  end
              end
        else#opcion 4
                @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @activities = Activity.joins(:user).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
               else
                  if current_user.rol == "Jefe de Departamento"
                    @activities = Activity.joins(:user).where(:users => {:rol => "investigador"}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                   else
                      @activities = Activity.joins(:user).where(:users => {:id => current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

     @activities2 = @activities
     @resultados = @activities.count
     @activities =  @activities.page(params[:page])

       respond_to do |format|
        format.html
        format.pdf do
           @activities = Activity.where(user_id: current_user.id, ano_periodo: Time.now.year).order(fecha_i: :desc)
          pdf = ActivityindexPdf.new(@activities2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de actividades académico administrativas.pdf",type: "application/pdf", disposition: "inline"
            end
     end
      
     end

  # GET /activities/1
  # GET /activities/1.json
  def show

  @userr = User.find(@activity.user_id)
 
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ActivityshowPdf.new(@activity, view_context, @userr)
       send_data  pdf.render, filename: "activity_#{@activity.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
          
  end

  def show2
@userr = User.find(@activity.user_id)
@activities = @activities
 respond_to do |format|
      format.html
      format.pdf do
        pdf = ActivityshowPdf.new(@activity, view_context, @userr)
       send_data  pdf.render, filename: "activity_#{@activity.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
          
  end


  # GET /activities/new
  def new
    @activity = Activity.new

  end

  # GET /activities/1/edit
  def edit

  end


  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
  
    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end
  end

  private
      # Use callbacks to share common setup or constraints between actions.
      def set_activity
        @activity = Activity.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def activity_params
        params.require(:activity).permit(:nombre, :tipo, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id)
      end

    
end
