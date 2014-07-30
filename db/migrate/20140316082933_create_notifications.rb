class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :user_id, null: false
    	t.references :notifiable, polymorphic: true, null: false
    	t.text :body, null: false
      t.boolean :from_comment, default: false
    	t.boolean :read, default: false

      t.timestamps
    end
    add_index :notifications, :user_id
    add_index :notifications, [:user_id, :notifiable_id, :notifiable_type, :from_comment], unique: true, name: "specific_notifications_index"
    add_index :notifications, [:user_id, :read]
  end
end
