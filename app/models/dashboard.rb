class Dashboard < ApplicationRecord
  include Usable

  has_many :dashboard_elements, -> { order(:position) }
  has_many :queries, through: :dashboard_elements


  has_and_belongs_to_many :users
end
