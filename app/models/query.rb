class Query < ApplicationRecord
  require "redis"
  has_paper_trail

  belongs_to :data_source

  has_and_belongs_to_many :users

  has_many :dashboard_elements
  has_many :dashboards, through: :dashboard_elements

  has_many :dynamic_fields

  has_secure_token :auth_token

  def self.find_restricted id, user_id
  	r = self.joins(:users).where("users.id = #{user_id} and queries.id = #{id}").first
  	if r.nil?
  		raise ActionController::RoutingError.new('Not Found')
  	end
    r
  end

  def interpreter_enum
    ['area','datatable', 'graph', 'csv', 'gauge', 'pie', 'sankey', 'number', 'stacked']
  end

  def get_data filters = nil
    if async
      redis = Redis.new
      value = redis.get("query#{id}")
      unless value.nil?
        value = JSON.parse(value)
        value["data"]
      end
    else
      execute filters
    end
  end

  def execute filters = nil
    q = self.body
    dynamic_fields.each do |field|
      if filters && filters[field.key]
        q = q.gsub(field.key, filters[field.key])
      else
        q = q.gsub(field.key, "''")
      end
    end
  	data_source.fetch(q).to_a
  end

  def presenter
    "Presenters::#{interpreter.titleize}"
  end


end
