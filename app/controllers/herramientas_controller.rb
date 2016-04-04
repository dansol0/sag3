class HerramientasController < ApplicationController
  before_filter :require_login
   layout :user_rol 


  def graficos
  end

  def estadisticas
  end

  def tablas
  	
  end


end
