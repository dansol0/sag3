class SubjectUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  validates_uniqueness_of :user_id, scope: :subject_id, message: "sólo puede registrarse una vez por actividad"
end
