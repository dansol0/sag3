class CreateWorkUsers < ActiveRecord::Migration
  def change
    create_table :work_users do |t|
      t.belongs_to :work, index: true
      t.belongs_to :user, index: true

    t.timestamps null: false
    end
  end
end
