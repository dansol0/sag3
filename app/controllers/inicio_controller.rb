class InicioController < ApplicationController
	before_filter :require_login, only: [:portal] 
	layout "application", only: [:index, :portal]
	layout :user_rol , only: [:portal]


  def index
  end

  def portal
  
  end


end
