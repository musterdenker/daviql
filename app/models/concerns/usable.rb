module Usable
  extend ActiveSupport::Concern

  included do
     has_many :usages, as: :usable
  end


  def add_usage user
    Usage.create(user: user, usable: self)
  end

end
