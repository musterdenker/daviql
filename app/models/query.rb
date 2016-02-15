class Query < ActiveRecord::Base

  belongs_to :data_source

  has_and_belongs_to_many :users

  def self.find_restricted id, user_id
  	r = self.joins(:users).where("users.id = #{user_id} and queries.id = #{id}").first
  	if r.nil?
  		raise ActionController::RoutingError.new('Not Found')
  	end
    r
  end

  def interpreter_enum
    ['datatable', 'graph', 'csv']
  end

  def execute
  	data_source.fetch self.body
  end

end
