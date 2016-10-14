class QueryVariable < ApplicationRecord
  belongs_to :query
  belongs_to :variable
end
