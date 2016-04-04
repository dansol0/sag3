class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /publications
  # GET /publications.json
  def menu_gestion_investigacion_publicacion
periodo = Period.where(estatus: 'Activo').take
       
     @publications = Publication.joins(:users).where(users: {id: current_user.id}).where(ano_periodo: periodo).order(fecha_i: :desc)
   
      @publications2 = @publications
     @resultados = @publications.count
     @publications =  @publications.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = PublicationindexPdf.new(@publications2, view_context)
         send_data  pdf.render, filename: "Lista de publicaciones del área de investigación.pdf",type: "application/pdf", disposition: "inline"
       end
     end
   end

  def buscar_menu
    
  end

  def buscar_publication
    
      
  end

  def buscar_titulo_publication
    
  end

  def buscar_fechas_publication
    
  end

  def buscar_investigador
    if current_user.rol == "administrador"
       # @users= User.all.where("id != ?", current_user.id)#todos los usuarios menos el
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
           @publications = Publication.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
        when 2
             @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @publications = Publication.joins(:users).search(params[:search]).order(fecha_i: :desc)
               else
                  if current_user.rol == "Jefe de Departamento"
                       @publications = Publication.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                  else
                      @publications = Publication.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                  end
              end
        when 3
              @ano_periodo=params[:ano_periodo]
             @revista_editorial=params[:revista_editorial]
             @arbitr_no_arbitr=params[:arbitr_no_arbitr]
              if current_user.rol == "administrador"
                   
   
                     if !params[:revista_editorial].blank?
                         if !params[:arbitr_no_arbitr].blank?
                             @publications = Publication.joins(:users).where("revista_editorial = ? AND ano_periodo = ? AND arbitr_no_arbitr = ?" , params[:revista_editorial],params[:ano_periodo] ,params[:arbitr_no_arbitr] ).order(fecha_i: :desc)  
                          else
                            @publications = Publication.joins(:users).where("revista_editorial = ? AND ano_periodo = ?" , params[:revista_editorial],params[:ano_periodo] ).order(fecha_i: :desc)
                         end

                     else
                        if !params[:arbitr_no_arbitr].blank?
                            @publications = Publication.joins(:users).where("arbitr_no_arbitr = ? AND ano_periodo = ?" , params[:arbitr_no_arbitr],params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                     end
                
              else
                  if current_user.rol == "Jefe de Departamento"
                        
     
                         if !params[:revista_editorial].blank?
                             if !params[:arbitr_no_arbitr].blank?
                                 @publications = Publication.joins(:users).where(users: {rol: 'investigador'}).where("revista_editorial = ? AND ano_periodo = ? AND arbitr_no_arbitr = ?" , params[:revista_editorial],params[:ano_periodo] ,params[:arbitr_no_arbitr] ).order(fecha_i: :desc)  
                             else
                                @publications = Publication.joins(:users).where(users: {rol: 'investigador'}).where("revista_editorial = ? AND ano_periodo = ?" , params[:revista_editorial],params[:ano_periodo] ).order(fecha_i: :desc)
                             end

                         else
                            if !params[:arbitr_no_arbitr].blank?
                                @publications = Publication.joins(:users).where(users: {rol: 'investigador'}).where("arbitr_no_arbitr = ? AND ano_periodo = ?" , params[:arbitr_no_arbitr],params[:ano_periodo] ).order(fecha_i: :desc)
                             end
                         end
                    
                  else
                    
     
                         if !params[:revista_editorial].blank?
                             if !params[:arbitr_no_arbitr].blank?
                                 @publications = Publication.joins(:users).where(users: {id: current_user.id}).where("creador = ? AND revista_editorial = ? AND ano_periodo = ? AND arbitr_no_arbitr = ?" ,params[:creador], params[:revista_editorial],params[:ano_periodo] ,params[:arbitr_no_arbitr] ).order(fecha_i: :desc)  
                             else
                                @publications = Publication.joins(:users).where(users: {id: current_user.id}).where("creador = ? AND revista_editorial = ? AND ano_periodo = ?" ,params[:creador], params[:revista_editorial],params[:ano_periodo] ).order(fecha_i: :desc)
                             end

                         else
                            if !params[:arbitr_no_arbitr].blank?
                                @publications = Publication.joins(:users).where(users: {id: current_user.id}).where("creador = ? AND arbitr_no_arbitr = ? AND ano_periodo = ?" ,params[:creador], params[:arbitr_no_arbitr],params[:ano_periodo] ).order(fecha_i: :desc)
                             end
                         end
                    
                  end
              end
        else#opcion 4
                @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @publications = Publication.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                    @publications = Publication.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  else
                      @publications = Publication.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

      @publications2 = @publications
     @resultados = @publications.count
     @publications =  @publications.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = PublicationindexPdf.new(@publications2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de publicaciones del área de investigación.pdf",type: "application/pdf", disposition: "inline"
       end
     end
    
end

  # GET /publications/1
  # GET /publications/1.json
  def show
      @user = User.all
    @userr = User.find(@publication.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = PublicationshowPdf.new(@publication, view_context, @userr)
       send_data  pdf.render, filename: "publication_#{@publication.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
  end

  def show2
      @user = User.all
    @userr = User.find(@publication.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = PublicationshowPdf.new(@publication, view_context, @userr)
       send_data  pdf.render, filename: "publication_#{@publication.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
  end


  # GET /publications/new
  def new
    @publication = Publication.new
    
  end

  # GET /publications/1/edit
  def edit
 @users = User.all.order(nombre1: :asc)
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(publication_params)
    @user = User.find(session[:user_id]) 
   
    respond_to do |format|
      if @publication.save
        @user.publications << @publication
        format.html { redirect_to @publication, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end

     
  end

  # PATCH/PUT /publications/1
  # PATCH/PUT /publications/1.json
  def update
    @users = User.all.order(nombre1: :asc)
    if params[:publication][:user_ids]
      params[:publication][:user_ids] = params[:publication][:user_ids].map{|k, v| k}
    else
      params[:publication][:user_ids] = []
    end
    
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end

     
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      format.html { redirect_to menu_investigacion_2_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publication_params
      params.require(:publication).permit(:titulo, :revista_editorial, :arbitr_no_arbitr, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, user_ids: [])
    end
end
