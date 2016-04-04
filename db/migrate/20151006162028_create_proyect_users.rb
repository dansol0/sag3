class CreateProyectUsers < ActiveRecord::Migration
  def change
    create_table :proyect_users do |t|
      t.belongs_to :proyect, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
