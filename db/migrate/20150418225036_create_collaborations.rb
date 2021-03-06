class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.references :user, index: true
      t.references :wiki, index: true

      t.timestamps null: false
    end
    add_foreign_key :collaborations, :users
    add_foreign_key :collaborations, :wikis
  end
end
