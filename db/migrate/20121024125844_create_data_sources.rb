class CreateDataSources < ActiveRecord::Migration
  def change
    create_table :data_sources do |t|
      t.string :name
      t.string :database_type
      t.string :host
      t.integer :port
      t.string :user
      t.string :password
      t.string :database_name

      t.timestamps
    end
  end
end
