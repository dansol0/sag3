class WorksController < ApplicationController
  before_action :set_work, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /works
  # GET /works.json
  def menu_gestion_docencia_trabajos
    periodo = Period.where(estatus: 'Activo').take
        
     @works = Work.joins(:users).where(users: {id: current_user.id}).where(ano_periodo: periodo).order(fecha_i: :desc)
  @works2 = @works
     @resultados = @works.count
     @works =  @works.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = WorkindexPdf.new(@works2, view_context)
         send_data  pdf.render, filename: "Lista de actividades de trabajos de grado del área de docencia.pdf",type: "application/pdf", disposition: "inline"
       end
     end
   end

  def buscar_menu
    
  end

  def buscar_work
    
     
  end

  def buscar_titulo_work
    
  end

  def buscar_fechas_work
    
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
           @works = Work.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
        when 2
              @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @works = Work.joins(:users).search(params[:search]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                       @works = Work.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                  else
                      @works = Work.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                 end
              end
        when 3
              @ano_periodo=params[:ano_periodo]
                    @tipo=params[:tipo]
              if current_user.rol == "administrador"
                    
                        if !params[:tipo].blank?
                        @works = Work.joins(:users).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                        else
                           @works = Work.joins(:users).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                   
              else
                  if current_user.rol == "Jefe de Departamento"
                        
                            if !params[:tipo].blank?
                            @works = Work.joins(:users).where(users: {rol: 'investigador'}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @works = Work.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  else
                        
                            if !params[:tipo].blank?
                            @works = Work.joins(:users).where(users: {id: current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @works = Work.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  end
              end
        else#opcion 4
                  
                    @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @works = Work.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
               else
                  if current_user.rol == "Jefe de Departamento"
                    @works = Work.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                   else
                      @works = Work.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

    @works2 = @works
     @resultados = @works.count
     @works =  @works.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = WorkindexPdf.new(@works2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de actividades de trabajos de grado del área de docencia.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  # GET /works/1
  # GET /works/1.json
  def show
    @user = User.all
    @userr = User.find(@work.creador)
        respond_to do |format|
      format.html
      format.pdf do
        pdf = WorkshowPdf.new(@work, view_context, @userr)
       send_data  pdf.render, filename: "work_#{@work.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
 end

  def show2
    @user = User.all
    @userr = User.find(@work.creador)
        respond_to do |format|
      format.html
      format.pdf do
        pdf = WorkshowPdf.new(@work, view_context, @userr)
       send_data  pdf.render, filename: "work_#{@work.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
 end


  # GET /works/new
  def new
    @work = Work.new
    
  end

  # GET /works/1/edit
  def edit
 @users = User.all.order(nombre1: :asc)
    
  end

  # POST /works
  # POST /works.json
  def create

    @work = Work.new(work_params)
    @user = User.find(session[:user_id]) 
   
    respond_to do |format|
      if @work.save
        @user.works << @work
        format.html { redirect_to @work, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end

   end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
@users = User.all.order(nombre1: :asc)
    if params[:work][:user_ids]
      params[:work][:user_ids] = params[:work][:user_ids].map{|k, v| k}
    else
      params[:work][:user_ids] = []
    end
    
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to menu_docencia_3_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.require(:work).permit(:tipo, :titulo, :autores, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador,  user_ids: [])
    end
end
