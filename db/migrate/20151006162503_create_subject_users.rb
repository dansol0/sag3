class CreateSubjectUsers < ActiveRecord::Migration
  def change
    create_table :subject_users do |t|
      t.belongs_to :subject, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
