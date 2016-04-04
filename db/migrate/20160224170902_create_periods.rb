class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods , id: false do |t|
      t.integer :ano_periodo, :null => false
      t.string :estatus, :null => false

      t.timestamps null: false
    end
     execute "ALTER TABLE periods ADD PRIMARY KEY (ano_periodo);"
    add_index :periods, :ano_periodo, unique: true
  end


end
