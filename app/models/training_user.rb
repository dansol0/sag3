class TrainingUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :training

  validates_uniqueness_of :user_id, scope: :training_id, message: "sólo puede registrarse una vez por actividad"

end
