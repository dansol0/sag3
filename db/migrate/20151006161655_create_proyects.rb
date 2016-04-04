class CreateProyects < ActiveRecord::Migration
  def change
    create_table :proyects do |t|
      t.string :titulo, :null => false
      t.string :estatus, :null => false, index: true
      t.string :ente_financista, :null => false 
      t.float :monto
      t.text :descripcion
      t.integer :horas
      t.date :fecha_i, :null => false
      t.date :fecha_f
      t.integer :ano_periodo, :null => false, index: true
      t.integer :creador, :null => false, index: true

      t.timestamps null: false
    end
  end
end
