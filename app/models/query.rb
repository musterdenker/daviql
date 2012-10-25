class Query < ActiveRecord::Base
  attr_accessible :body, :interpreter, :name, :data_source_id

  belongs_to :data_source

  def execute
  	self.data_source.fetch self.body
  end

end
