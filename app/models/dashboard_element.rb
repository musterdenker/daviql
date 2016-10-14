class DashboardElement < ApplicationRecord
  belongs_to :dashboard
  belongs_to :query
end
