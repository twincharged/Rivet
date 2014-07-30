class CreateBannedUsers < ActiveRecord::Migration
  def change
    create_table :banned_users do |t|
      t.string  :email
      t.text    :ban_report

      t.timestamps
    end
    add_index :banned_users, :email
  end
end
