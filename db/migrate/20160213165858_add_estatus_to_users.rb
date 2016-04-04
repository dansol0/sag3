class AddEstatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :estatus, :string
  end
end
