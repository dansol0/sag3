class AddIntegrantesToProyects < ActiveRecord::Migration
  def change
    add_column :proyects, :integrantes, :text
  end
end
