class AddFieldTypeToDynamicFields < ActiveRecord::Migration[5.0]
  def change
    add_column :dynamic_fields, :field_type, :string
  end
end
