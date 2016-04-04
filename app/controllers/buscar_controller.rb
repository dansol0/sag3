class BuscarController < ApplicationController
  before_filter :require_login

  def area
     
  end

 
  def investigador
  	  
  end


  def filtro
        
  		@user = User.all
    @userr = User.find(@coference.creador)

  end	

end
