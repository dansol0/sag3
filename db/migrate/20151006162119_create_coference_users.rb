class CreateCoferenceUsers < ActiveRecord::Migration
  def change
    create_table :coference_users do |t|
      t.belongs_to :coference, index: true
      t.belongs_to :user, index: true
      
      t.timestamps null: false
     
    end
  end
end
