class AddWidthAndHeightToDashboardElement < ActiveRecord::Migration[5.0]
  def change
    add_column :dashboard_elements, :width, :integer
    add_column :dashboard_elements, :height, :integer
  end
end
