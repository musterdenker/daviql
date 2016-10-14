class CreateQueryVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :query_variables do |t|
      t.belongs_to :queries, foreign_key: true
      t.belongs_to :variables, foreign_key: true
      t.string :default_value

      t.timestamps
    end
  end
end
