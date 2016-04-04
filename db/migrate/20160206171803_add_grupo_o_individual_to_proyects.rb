class AddGrupoOIndividualToProyects < ActiveRecord::Migration
  def change
    add_column :proyects, :grupo_o_individual, :string
  end
end
