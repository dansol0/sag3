class TutoringUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :tutoring

  validates_uniqueness_of :user_id, scope: :tutoring_id, message: "sólo puede registrarse una vez por actividad"

end
