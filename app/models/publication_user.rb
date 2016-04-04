class PublicationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :publication

 validates_uniqueness_of :user_id, scope: :publication_id, message: "sólo puede registrarse una vez por actividad"

end
