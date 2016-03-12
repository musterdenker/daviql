class AddDescriptionToDashboard < ActiveRecord::Migration[5.0]
  def change
    add_column :dashboards, :description, :text
  end
end
