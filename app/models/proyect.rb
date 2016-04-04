class Proyect < ActiveRecord::Base
	has_many :proyect_users, :dependent => :destroy, inverse_of: :proyect
  has_many :users, through: :proyect_users

  attr_accessible :bolivares, :user_ids, :titulo, :estatus, :ente_financista, :integrantes, :monto, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, :investigador_responsable, :co_investigador, :grupo_o_individual
    
 validates :grupo_o_individual, :presence => {:message => "- Seleccione si el proyecto es en grupo o individual"}   
 validates :estatus, :presence => {:message => "- Debe ingresar el estatus del proyecto"}
 validates :ente_financista, :presence => {:message => "- Debe ingresar el ente financista del proyecto"}
 validates :titulo, :presence => {:message => "- Debe ingresar el titulo delproyecto"}
 #validates :integrantes, :presence => {:message => "- Debe ingresar los nombre de los integrantes del proyecto"}
 validates :fecha_i, :presence => {:message => "- Debe ingresar la fecha de inicio de la actividad"}
 validates :ano_periodo, :presence => {:message => "- Debe ingresar el año del período"}
 validates :creador, presence: true
 validates :investigador_responsable, :presence => {:message => "- Debe seleccionar el investigador responsable del proyecto"}
 validates :co_investigador, :presence => {:message => "- Debe seleccionar el Co-investigador del proyecto"}
validates :fecha_f,
          date: { allow_blank: true, after_or_equal_to: :fecha_i , message: ' .... LA FECHA DE FIN DE LA ACTIVIDAD DEBE SER MAYOR O IGUAL A LA FECHA DE INICIO' },
  on: :create

validates :ano_periodo, length: { is: 4, message: "- El año del periodo debe ser de 4 digitos"}

validates :fecha_f,
          date: { allow_blank: true,after_or_equal_to: :fecha_i , message: ' .... LA FECHA DE FIN DE LA ACTIVIDAD DEBE SER MAYOR O IGUAL A LA FECHA DE INICIO' }
  
validates :fecha_f,
          date: { allow_blank: true,before_or_equal_to: Proc.new { Date.today }, message: ' .... LA FECHA DE FIN DEBE SER ANTES O IGUAL QUE LA FECHA ACTUAL' } 

#validates :fecha_i, date: { before_or_equal_to: :fecha_f }, message: ' .... LA FECHA DE INICIO DEBE SER ANTES DE LA FECHA DE FIN' }
validates :fecha_i, date: { before_or_equal_to: Proc.new { Date.today }, message: ' .... LA FECHA DE INICIO NO PUEDE SER MAYOR A LA FECHA ACTUAL' } 

  def self.search(search)
  	if search
      where('titulo ILIKE ?', "%#{search}%")
    else
      scoped
   
    end
  end

  

  def bolivares
      "#{monto} Bs" 
  end

end
