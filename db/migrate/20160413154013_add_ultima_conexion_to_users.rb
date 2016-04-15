class AddUltimaConexionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ultima_conexion, :date
  end
end
