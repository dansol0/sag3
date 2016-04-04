class ExtensionUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :extension

  validates_uniqueness_of :user_id, scope: :extension_id, message: "sólo puede registrarse una vez por actividad"

end
