class ChangeEstatusToestatusUser < ActiveRecord::Migration
  def change
  	 rename_column :users, :estatus, :estatus_user
  end
end
