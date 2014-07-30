class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :blocker_id, null: false
      t.references :blockable, polymorphic: true

      t.timestamps
    end
    add_index :blocks, :blocker_id
    add_index :blocks, [:blocker_id, :blockable_id, :blockable_type], unique: true
  end
end
