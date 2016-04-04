class CreateResearchUsers < ActiveRecord::Migration
  def change
    create_table :research_users do |t|
      t.belongs_to :research, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
