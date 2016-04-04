class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :titulo, :null => false
      t.string :revista_editorial, :null => false, index: true
      t.string :arbitr_no_arbitr
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
