class RenameDashboardsQueriesToDashboardElements < ActiveRecord::Migration[5.0]
  def change
    rename_table :dashboards_queries, :dashboard_elements
  end
end
