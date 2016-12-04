class AddUsageTable < ActiveRecord::Migration
  def change
    create_table :usages do |t|
      t.integer :user_id
      t.integer :usable_id
      t.string :usable_type
      t.timestamps
    end
  end
end
