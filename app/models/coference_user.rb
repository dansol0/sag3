class CoferenceUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :coference

 validates_uniqueness_of :user_id, scope: :coference_id, message: "sólo puede registrarse una vez por actividad"
end
