class AddInvestigadorResponsableToProyects < ActiveRecord::Migration
  def change
    add_column :proyects, :investigador_responsable, :string
  end
end
