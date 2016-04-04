class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :nombre, :null => false
      t.string :tipo, :null => false, index: true
      t.text :descripcion
      t.integer :horas
      t.date :fecha_i, :null => false
      t.date :fecha_f
      t.integer :ano_periodo, :null => false, index: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
