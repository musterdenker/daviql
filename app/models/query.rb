class Query < ActiveRecord::Base
  attr_accessible :body, :interpreter, :name, :data_source_id, :description

  belongs_to :data_source

  def interpreter_enum
    ['datatable', 'graph']
  end

  def execute
  	self.data_source.fetch self.body
  end

end
