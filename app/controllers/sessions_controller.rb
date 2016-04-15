class SessionsController < ApplicationController
  def new
  end

  def index
  end

   def create
      user = login(params[:id], params[:password],params[:remember_me])
      if user
          if current_user.rol == "administrador" 
             render 'inicio/portal'
          else
                   if current_user.rol == "Jefe de Departamento"
                      render 'inicio/portal'
                    else
                       render 'inicio/portal'
                    end
          end
                                        
       else
        flash[:notice] = "Cedula o password incorrectos."
        redirect_to root_url
      end
  end

  def destroy
	  logout
    flash[:notice] = "Ha cerrado la sesion!"
	  redirect_to root_url
	end
end
