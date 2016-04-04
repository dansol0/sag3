class ResearchesController < ApplicationController
  before_action :set_research, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
@researches
  # GET /researches
  # GET /researches.json
 def menu_gestion_investigacion
  periodo = Period.where(estatus: 'Activo').take
      
     @researches = Research.joins(:users).where(users: {id: current_user.id}).where(ano_periodo: periodo).order(fecha_i: :desc)
      @researches2 = @researches
     @resultados = @researches.count
     @researches =  @researches.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = ResearchindexPdf.new(@researches2, view_context)
         send_data  pdf.render, filename: "Lista de otras actividades del área de investigación.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  def buscar_menu
    
  end

  def buscar_research
    
       
 
  end

  def buscar_titulo_research
    
  end

  def buscar_fechas_research
    
  end

  def buscar_investigador

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
           @researches = Research.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
         when 2
             @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @researches = Research.joins(:users).search(params[:search]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                       @researches = Research.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                  else
                      @researches = Research.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                  end
              end
        when 3
                @ano_periodo=params[:ano_periodo]
                    @tipo=params[:tipo]
              if current_user.rol == "administrador"
                   
                        if !params[:tipo].blank?
                        @researches = Research.joins(:users).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                        else
                           @researches = Research.joins(:users).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                         end
                    
              else
                  if current_user.rol == "Jefe de Departamento"
                       
                            if !params[:tipo].blank?
                            @researches = Research.joins(:users).where(users: {rol: 'investigador'}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                             else
                               @researches = Research.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                       
                  else
                        
                            if !params[:tipo].blank?
                            @researches = Research.joins(:users).where(users: {id: current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                           else
                               @researches = Research.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  end
              end
        else#opcion 4
                @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @researches = Research.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                    @researches = Research.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  else
                      @researches = Research.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end


           
        
        end
        
            
            @resultados = @researches.count
            @researches =  @researches.page(params[:page])

  end


 

  # GET /researches/1
  # GET /researches/1.json
  def show
    @user = User.all
    @userr = User.find(@research.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = ResearchshowPdf.new(@research, view_context, @userr)
       send_data  pdf.render, filename: "research_#{@research.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
  end

  def show2
    @user = User.all
    @userr = User.find(@research.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = ResearchshowPdf.new(@research, view_context, @userr)
       send_data  pdf.render, filename: "research_#{@research.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
  end

  # GET /researches/new
  def new
    @research = Research.new
    
  end

  # GET /researches/1/edit
  def edit
     @users = User.all.order(nombre1: :asc)
    
  end

  # POST /researches
  # POST /researches.json
  def create

  
    @research = Research.new(research_params)
    @user = User.find(session[:user_id]) 
   
    respond_to do |format|
      if @research.save
        @user.researches << @research
        format.html { redirect_to @research, notice: 'La actividad se registro con exito..' }
        format.json { render :show, status: :created, location: @research }
      else
        format.html { render :new }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /researches/1
  # PATCH/PUT /researches/1.json
  def update
@users = User.all.order(nombre1: :asc)
    if params[:research][:user_ids]
      params[:research][:user_ids] = params[:research][:user_ids].map{|k, v| k}
    else
      params[:research][:user_ids] = []
    end
    
    respond_to do |format|
      if @research.update(research_params)
        format.html { redirect_to @research, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @research }
      else
        format.html { render :edit }
        format.json { render json: @research.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /researches/1
  # DELETE /researches/1.json
  def destroy
    @research.destroy
    respond_to do |format|
      format.html { redirect_to menu_investigacion_3_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_research
      @research = Research.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def research_params
      params.require(:research).permit(:tipo, :nombre,  :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, user_ids: [])
    end

    

     def get_variable
         @researches2 = @researches
            
           respond_to do |format|

                    format.html
                    format.pdf do
                      pdf = ResearchindexPdf.new( @researches2, view_context)
                     send_data  pdf.render, filename: "Resultado de busqueda de actividades del área de investigación.pdf",type: "application/pdf", disposition: "inline"
                     end
                   end
     end
 
end
