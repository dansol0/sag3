class ResearchUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :research

 validates_uniqueness_of :user_id, scope: :research_id, message: "sólo puede registrarse una vez por actividad"

end
