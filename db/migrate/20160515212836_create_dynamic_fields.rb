class CreateDynamicFields < ActiveRecord::Migration[5.0]
  def change
    create_table :dynamic_fields do |t|
      t.string :key
      t.integer :position
      t.integer :query_id

      t.timestamps
    end
  end
end
