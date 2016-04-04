class User < ActiveRecord::Base
  authenticates_with_sorcery!

  

  has_many :coference_users, :dependent => :destroy, inverse_of: :user
  has_many :coferences, through: :coference_users

  has_many :proyects, through: :proyect_users
  has_many :proyect_users, :dependent => :destroy, inverse_of: :user

  has_many :activities

  
  has_many :extensions, through: :extension_users
  has_many :extension_users, :dependent => :destroy, inverse_of: :user

  has_many :publications, through: :publication_users
  has_many :publication_users, :dependent => :destroy, inverse_of: :user

  has_many :researches, through: :research_users
  has_many :research_users, inverse_of: :user, :dependent => :destroy

  has_many :subjects, through: :subject_users
  has_many :subject_users, :dependent => :destroy, inverse_of: :user

  
  has_many :teachings, through: :teaching_users
  has_many :teaching_users, :dependent => :destroy, inverse_of: :user

  has_many :trainings, through: :training_users
  has_many :training_users, :dependent => :destroy, inverse_of: :user

  has_many :tutorings, through: :tutoring_users
  has_many :tutoring_users, :dependent => :destroy, inverse_of: :user

  has_many :works, through: :work_users
  has_many :work_users, :dependent => :destroy, inverse_of: :user


  self.primary_key = 'id'

 attr_accessible  :nombre_apellido, :id, :email, :nombre1, :password, :password_confirmation, :nombre2,  :apellido1, :apellido2, :direccion, :tlf, :rol, :dedicacion, :cargo, :area, :categoria_actual, :anos_serv, :adscrito, :fecha_ult_ascenso, :grado_academico, :estatus_user
	  
	  	
		validates :id, :presence => {:message => "- Usted debe ingresar una cedula"},uniqueness: {case_sensitive: false ,message: "- La cedula que introdujo ya se encuentra  registrada"}, :numericality => {:only_integer => true, :message => "La cedula debe ser numérica"}
		validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create,  message: '- El formato del correo es invalido.'
		validates :email, :presence => {:message => "- Debe ingresar el correo"},uniqueness: {case_sensitive: false ,message: "- El que introdujo ya se encuentra  registrada"}
		
    
    validates :password, presence: { message: "- Debe ingresar una contraseña" }
    validates :password, length: { in: 4..12 , message: "- La contraseña debe tener entre 4 y 12 caracteres"}, if: -> { new_record? || changes[:crypted_password] }

    validates :password, confirmation: { message: "- La contraseña y la confirmación deben ser iguales" }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: { message: "- Debe ingresar la confirmación de la contraseña" }, if: -> { new_record? || changes[:crypted_password] }
   
 validates :tlf, format: { with: /0\d{3}-\d{4}/, message: "El número de teléfono con formato incorrecto. Ejemplo: 0212-1234567" }
	   
     validates :cargo, :presence => {:message => "- Debe ingresar el CARGO del investigador"}
     validates :estatus_user, :presence => {:message => "- Debe ingresar el ESTATUS del investigador"}
      validates :area, :presence => {:message => "- Debe ingresar el ÁREA del investigador"}
	   validates :nombre1, :presence => {:message => "- Debe ingresar el PRIMER NOMBRE del usuario"}, length: { maximum: 30 , :message => "- El primer nombre no puede contener mas de 30 letras"}
	   validates :apellido1, :presence => {:message => "- Debe ingresar el PRIMER APELLIDO del usuario"}, length: { maximum: 30 , :message => "- El primer apellido no puede contener mas de 30 letras"}
	  validates :nombre2, length: { maximum: 30 , :message => "- El segundo nombre no puede contener mas de 30 letras"}
    validates :apellido2, length: { maximum: 30 , :message => "- El segundo apellido no puede contener mas de 30 letras"}
     validates :rol, :presence => {:message => "- Debe ingresar el ROL del usuario"}

def nombre_apellido
    "#{nombre1.upcase}  #{apellido1.upcase}" 
  end

  



end
