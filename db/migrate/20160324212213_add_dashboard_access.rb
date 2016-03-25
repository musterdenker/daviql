class AddDashboardAccess < ActiveRecord::Migration[5.0]
  def self.up
    create_table :dashboards_users, :id => false do |t|
        t.references :dashboard
        t.references :user
    end
    add_index :dashboards_users, [:dashboard_id, :user_id]
    add_index :dashboards_users, [:user_id, :dashboard_id]
  end

  def self.down
    drop_table :dashboards_users
  end
end
