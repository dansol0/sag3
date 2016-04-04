class CreatePublicationUsers < ActiveRecord::Migration
  def change
    create_table :publication_users do |t|
      t.belongs_to :publication, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
