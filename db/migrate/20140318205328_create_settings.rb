class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.boolean :follower_approval, default: false
      t.boolean :email_notifications, default: true
      t.boolean :lock_all_self_content, default: false


      t.timestamps
    end
    add_index :settings, :user_id
    add_index :settings, [:user_id, :follower_approval]
  end
end
