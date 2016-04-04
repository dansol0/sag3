class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :tipo, :null => false, index: true
      t.string :titulo, :null => false
      t.text :autores, :null => false, index: true
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
