class Training < ActiveRecord::Base
	has_many :training_users, :dependent => :destroy, inverse_of: :training
  has_many :users, through: :training_users
  
  attr_accessible :user_ids, :tipo, :nombre,  :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador
validates :tipo, :presence => {:message => "- Debe seleccionar el tipo de la actividad"}
 validates :nombre, :presence => {:message => "- Debe ingresar el nombre de la actividad"}
 validates :fecha_i, :presence => {:message => "- Debe ingresar la fecha de inicio de la actividad"}
 validates :ano_periodo, :presence => {:message => "- Debe ingresar el año del período"}
 validates :creador, presence: true

 validates :fecha_f,
          date: { allow_blank: true, after_or_equal_to: :fecha_i , message: ' .... LA FECHA DE FIN DE LA ACTIVIDAD DEBE SER MAYOR O IGUAL A LA FECHA DE INICIO' },
  on: :create

validates :ano_periodo, length: { is: 4, message: "- El año del periodo debe ser de 4 digitos"}

validates :fecha_f,
          date: { allow_blank: true,after_or_equal_to: :fecha_i , message: ' .... LA FECHA DE FIN DE LA ACTIVIDAD DEBE SER MAYOR O IGUAL A LA FECHA DE INICIO' }
  
validates :fecha_f,
         date: {allow_blank: true, before_or_equal_to: Proc.new { Date.today }, message: ' .... LA FECHA DE FIN DEBE SER ANTES O IGUAL QUE LA FECHA ACTUAL' } 

#validates :fecha_i, date: { before_or_equal_to: :fecha_f }, message: ' .... LA FECHA DE INICIO DEBE SER ANTES DE LA FECHA DE FIN' }
validates :fecha_i, date: { before_or_equal_to: Proc.new { Date.today }, message: ' .... LA FECHA DE INICIO NO PUEDE SER MAYOR A LA FECHA ACTUAL' } 

 def self.search(search)
  if search
    where('nombre ILIKE ?', "%#{search}%")
  else
    scoped
 
  end
end
end
