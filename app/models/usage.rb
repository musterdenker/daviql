class Usage < ActiveRecord::Base

  belongs_to :usable, polymorphic: true
  belongs_to :user
end
