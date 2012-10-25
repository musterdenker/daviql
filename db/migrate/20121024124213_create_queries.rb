class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :name
      t.text :body
      t.string :interpreter
      t.integer :data_source_id

      t.timestamps
    end
  end
end
