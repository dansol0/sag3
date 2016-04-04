class CreateExtensionUsers < ActiveRecord::Migration
  def change
    create_table :extension_users do |t|
      t.belongs_to :extension, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
