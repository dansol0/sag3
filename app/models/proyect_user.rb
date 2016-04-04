class ProyectUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :proyect

  validates_uniqueness_of :user_id, scope: :proyect_id, message: "sólo puede registrarse una vez por actividad"
end

