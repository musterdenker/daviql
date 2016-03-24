class Query < ApplicationRecord
  require "redis"

  belongs_to :data_source

  has_and_belongs_to_many :users

  has_many :dashboard_elements
  has_many :dashboards, through: :dashboard_elements

  has_secure_token :auth_token

  def self.find_restricted id, user_id
  	r = self.joins(:users).where("users.id = #{user_id} and queries.id = #{id}").first
  	if r.nil?
  		raise ActionController::RoutingError.new('Not Found')
  	end
    r
  end

  def interpreter_enum
    ['datatable', 'graph', 'csv', 'gauge', 'pie', 'sankey']
  end

  def get_data
    if async
      redis = Redis.new
      value = redis.get("query#{id}")
      unless value.nil?
        value = JSON.parse(value)
        value["data"]
      end
    else
      execute
    end
  end

  def execute
  	data_source.fetch(self.body).to_a
  end

  def presenter
    "Presenters::#{interpreter.titleize}"
  end


end
