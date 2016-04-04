class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery
 layout :user_rol

  private

  def not_authenticated
       flash[:error] = "Primero debes iniciar sesion."
        redirect_to root_url

  #  redirect_to  login_url, notice: => "Primero debes iniciar sesion para visualizar esta pagina."
  end

 
   def user_rol
          if current_user.rol == "administrador" 
             "p_administrador"
          else
              if current_user.rol == "Jefe de Departamento"
                 "p_coordinador"
              else
                  "p_investigador"
              end
          end
    end
end
