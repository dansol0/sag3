class CreateTeachingUsers < ActiveRecord::Migration
  def change
    create_table :teaching_users do |t|
      t.belongs_to :teaching, index: true
      t.belongs_to :user, index: true

    t.timestamps null: false
    end
  end
end
