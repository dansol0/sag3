class Period < ActiveRecord::Base
	
	  attr_accessible :ano_periodo, :estatus
	  self.primary_key = 'ano_periodo'

      validates :ano_periodo, uniqueness:  {
    message: "-- Este período ya se encuentra registrado" }
	  validates :ano_periodo, :presence => {:message => "- Debe seleccionar el Período"}
	  validates :estatus, :presence => {:message => "- Debe seleccionar el estatus del Período"}
	  validates :ano_periodo, length: { is: 4, message: "- El año del periodo debe ser de 4 digitos"}
      
         
     
end
