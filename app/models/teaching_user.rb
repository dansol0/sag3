class TeachingUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :teaching

  validates_uniqueness_of :user_id, scope: :teaching_id, message: "sólo puede registrarse una vez por actividad"

end
