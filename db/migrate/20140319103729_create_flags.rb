class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.integer :user_id
      t.references :flagable, polymorphic: true

      t.timestamps
    end
    add_index :flags, [:flagable_type, :flagable_id]
  end
end
