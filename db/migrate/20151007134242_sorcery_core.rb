class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.string :email,            :null => false
      t.string :crypted_password,  :default => nil 
      t.string :salt,              :default => nil 

      t.integer :id, :null => false
      t.string :nombre1, :null => false
      t.string :nombre2
      t.string :apellido1, :null => false
      t.string :apellido2
      t.text :direccion
      t.string :password
      t.string :tlf
      t.string :rol, :null => false
      t.string :dedicacion
      t.string :cargo, :null => false
      t.string :area
      t.string :categoria_actual
      t.integer :anos_serv
      t.string :adscrito
      t.date :fecha_ult_ascenso
      t.string :grado_academico

      t.timestamps
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
    add_index :users, :email, unique: true
    add_index :users, :id, unique: true
  end
end