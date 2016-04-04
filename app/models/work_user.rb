class WorkUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :work

  validates_uniqueness_of :user_id, scope: :work_id, message: "sólo puede registrarse una vez por actividad"

end
