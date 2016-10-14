class Variable < ApplicationRecord
  has_many :query_variables
  has_many :queries, through: :query_variables

  rails_admin do
    configure :query_variables do
      visible(false)
    end
    configure :queries do
      visible(false)
    end
  end
end
