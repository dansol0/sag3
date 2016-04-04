class Coference < ActiveRecord::Base
has_many :coference_users, :dependent => :destroy, inverse_of: :coference
has_many :users, through: :coference_users

attr_accessible :tipo, :titulo, :evento, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :creador, :user_ids

 validates :tipo, :presence => {:message => "- Debe seleccionar el tipo de la actividad"}
 validates :titulo, :presence => {:message => "- Debe ingresar el titulo de la actividad"}
 validates :evento, :presence => {:message => "- Debe seleccionar una de las opciones en el campo evento"}
 validates :fecha_i, :presence => {:message => "- Debe ingresar la fecha de inicio de la actividad"}
 validates :ano_periodo, :presence => {:message => "- Debe ingresar el año del período"}
 validates :creador, presence: true

validates :fecha_i, date: { before_or_equal_to: Proc.new { Date.today }, message: ' .... LA FECHA DE INICIO NO PUEDE SER MAYOR A LA FECHA ACTUAL' } 

 validates :fecha_f,
          date: { allow_blank: true, after_or_equal_to: :fecha_i , message: ' .... LA FECHA DE FIN DE LA ACTIVIDAD DEBE SER MAYOR O IGUAL A LA FECHA DE INICIO' },
  on: :create
validates :ano_periodo, length: { is: 4, message: "- El año del periodo debe ser de 4 digitos"}

validates :fecha_f,
          date: { allow_blank: true,after_or_equal_to: :fecha_i , message: ' .... LA FECHA DE FIN DE LA ACTIVIDAD DEBE SER MAYOR O IGUAL A LA FECHA DE INICIO' }
  
validates :fecha_f,
          date: { allow_blank: true, before_or_equal_to: Proc.new { Date.today }, message: ' .... LA FECHA DE FIN DEBE SER ANTES O IGUAL QUE LA FECHA ACTUAL' } 


#validates :fecha_i, date: { before_or_equal_to: :fecha_f , message: ' .... LA FECHA DE INICIO DEBE SER ANTES O IGUAL A LA FECHA DE FIN' }

def self.search(search)
  if search
    where('titulo ILIKE ?', "%#{search}%")
  else
    scoped
 
  end
end

end
