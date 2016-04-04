class CreateTeachings < ActiveRecord::Migration
  def change
    create_table :teachings do |t|
      t.string :nombre, :null => false
      t.string :tipo, :null => false, index: true
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
