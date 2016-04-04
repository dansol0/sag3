class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show2, :show, :edit, :update, :destroy]
before_filter :require_login
  # GET /subjects
  # GET /subjects.json

  def tabla_oferta_de_asignatura_de_pregrado
        periodo = Period.where(estatus: 'Activo').take

     @subjects = Subject.where(tipo: 'Pregrado', ano_periodo: periodo).order(fecha_i: :desc)
    @cantidad_de_pregrado = @subjects.count
  @subjects2 =  @subjects.page(params[:page])

 
   #Aqui guardare el nombre y apellido de los creadores de cada asignatura 
#(esto es temporalmente en la variable descripcion q es un string)
@subjects.each do |subject|
    @user= User.find(subject.creador).nombre_apellido
    subject.descripcion=  @user
   end

       respond_to do |format|
        format.html
        format.pdf do
          pdf = TablaAsignaturasDePregradoPdf.new(@subjects, view_context)
         send_data  pdf.render, filename: "Lista de asiganturas de pregrado.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  def tabla_oferta_de_asignatura_de_postgrado
        periodo = Period.where(estatus: 'Activo').take
      @subjects = Subject.where(tipo: 'Postgrado', ano_periodo: periodo).order(fecha_i: :desc)
      @cantidad_de_postgrado = @subjects.count
    @subjects2 =  @subjects.page(params[:page])
     
#Aqui guardare el nombre y apellido de los creadores de cada asignatura 
#(esto es temporalmente en la variable descripcion q es un string)
@subjects.each do |subject|
    @user= User.find(subject.creador).nombre_apellido
    subject.descripcion=  @user
   end 
     

      respond_to do |format|
          format.html
          format.pdf do
            pdf = TablaAsignaturasDePostgradoPdf.new(@subjects, view_context)
           send_data  pdf.render, filename: "Lista de asiganturas de postgrado.pdf",type: "application/pdf", disposition: "inline"
         end
       end
  end

   def tabla_resumen_totalizador_de_asignaturas_de_postgrado_pregrado
        periodo = Period.where(estatus: 'Activo').take
     @subjects_de_postgrado = Subject.where(tipo: 'Postgrado', ano_periodo: periodo).order(fecha_i: :desc)
     @subjects_pregrado = Subject.where(tipo: 'Pregrado', ano_periodo: periodo).order(fecha_i: :desc)
     
     @cantidad_de_postgrado = @subjects_de_postgrado.count
     @cantidad_de_pregrado = @subjects_pregrado.count

     @resultados = @cantidad_de_postgrado + @cantidad_de_pregrado

       respond_to do |format|
        format.html
        format.pdf do
          pdf = ResumenTotalizadorDeAsignaturasPdf.new(@cantidad_de_postgrado, @cantidad_de_pregrado, view_context)
         send_data  pdf.render, filename: "Resumen totalizador de asiganturas.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  def menu_gestion_docencia_asignatura
    @subjects = Subject.joins(:users).where(users: {id: current_user.id}).where(ano_periodo: Time.now.year).order(fecha_i: :desc)
   @subjects2 = @subjects
     @resultados = @subjects.count
     @subjects =  @subjects.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = SubjectindexPdf.new(@subjects2, view_context)
         send_data  pdf.render, filename: "Lista de actividades de dictado de asignaturas del área de docencia.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  def buscar_menu
    
  end

  def buscar_subject
    
 
  end

  def buscar_titulo_subject
    
  end

  def buscar_fechas_subject
    
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
           @subjects = Subject.joins(:users).where(users: {id: params[:user_ids]}).order(fecha_i: :desc)
        when 2
             @search = params[:search].to_s
              if current_user.rol == "administrador"
                 @subjects = Subject.joins(:users).search(params[:search]).order(fecha_i: :desc)
              else
                  if current_user.rol == "Jefe de Departamento"
                       @subjects = Subject.joins(:users).where(users: {rol: 'investigador'}).search(params[:search]).order(fecha_i: :desc)
                  else
                      @subjects = Subject.joins(:users).where(users: {id: current_user.id}).search(params[:search]).order(fecha_i: :desc)
                 end
              end
        when 3
              @ano_periodo=params[:ano_periodo]
                    @tipo=params[:tipo]
              if current_user.rol == "administrador"
                    
                        if !params[:tipo].blank?
                        @subjects = Subject.joins(:users).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                        else
                           @subjects = Subject.joins(:users).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                        end
                    
              else
                  if current_user.rol == "Jefe de Departamento"
                        
                            if !params[:tipo].blank?
                            @subjects = Subject.joins(:users).where(users: {rol: 'investigador'}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @subjects = Subject.joins(:users).where(users: {rol: 'investigador'}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                           end
                        
                  else
                        
                            if !params[:tipo].blank?
                            @subjects = Subject.joins(:users).where(users: {id: current_user.id}).where("tipo = ? AND ano_periodo = ?" , params[:tipo],params[:ano_periodo] ).order(fecha_i: :desc)
                            else
                               @subjects = Subject.joins(:users).where(users: {id: current_user.id}).where("ano_periodo = ?" , params[:ano_periodo] ).order(fecha_i: :desc)
                            end
                        
                  end
              end
        else#opcion 4
                @fecha_hasta=params[:fecha_hasta]
                    @fecha_desde=params[:fecha_desde]
              if current_user.rol == "administrador"
                @subjects = Subject.joins(:users).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
               else
                  if current_user.rol == "Jefe de Departamento"
                    @subjects = Subject.joins(:users).where(users: {rol: 'investigador'}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  else
                      @subjects = Subject.joins(:users).where(users: {id: current_user.id}).where(fecha_i: params[:fecha_desde]..params[:fecha_hasta]).order(fecha_i: :desc)
                  end
              end
        end

    @subjects2 = @subjects
     @resultados = @subjects.count
     @subjects =  @subjects.page(params[:page])

     respond_to do |format|
        format.html
        format.pdf do
          pdf = SubjectindexPdf.new(@subjects2, view_context)
         send_data  pdf.render, filename: "Resultado de busqueda de actividades de dictado de asignaturas del área de docencia.pdf",type: "application/pdf", disposition: "inline"
       end
     end
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
      @user = User.all
    @userr = User.find(@subject.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = SubjectshowPdf.new(@subject, view_context, @userr)
       send_data  pdf.render, filename: "subject_#{@subject.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
     
  end

  def show2
      @user = User.all
    @userr = User.find(@subject.creador)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = SubjectshowPdf.new(@subject, view_context, @userr)
       send_data  pdf.render, filename: "subject_#{@subject.id}.pdf",type: "application/pdf", disposition: "inline"
                  
      end
     end
     
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
   
  end

  # GET /subjects/1/edit
  def edit
 @users = User.all.order(nombre1: :asc)
     
  end

  # POST /subjects
  # POST /subjects.json
  def create

    @subject = Subject.new(subject_params)
    @user = User.find(session[:user_id]) 
   
    respond_to do |format|
      if @subject.save
        @user.subjects << @subject
        format.html { redirect_to @subject, notice: 'La actividad se registro con exito.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
@users = User.all.order(nombre1: :asc)
    if params[:subject][:user_ids]
      params[:subject][:user_ids] = params[:subject][:user_ids].map{|k, v| k}
    else
      params[:subject][:user_ids] = []
    end
    
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'La actividad se actualizo con exito.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to menu_docencia_1_path, notice: 'La actividad se elimino con exito.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:tipo,  :nombre, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, user_ids: [])
    end
end
