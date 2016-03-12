class CreateDashboardsQueries < ActiveRecord::Migration[5.0]
  def change
    create_table :dashboards_queries do |t|
      t.belongs_to :dashboard
      t.belongs_to :query
      t.integer :position
    end
  end
end
