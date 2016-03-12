class Dashboard < ApplicationRecord
  has_many :dashboard_elements,  -> { order(:position) }
  has_many :queries, through: :dashboard_elements
end
