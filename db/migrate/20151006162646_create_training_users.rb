class CreateTrainingUsers < ActiveRecord::Migration
  def change
    create_table :training_users do |t|
      t.belongs_to :training, index: true
      t.belongs_to :user, index: true

    t.timestamps null: false
    end
  end
end
