class DynamicField < ApplicationRecord
  belongs_to :query


  def field
    "Fields::#{field_type.titleize}".constantize.new(self)
  end

  def field_type_enum
    ['text']
  end


end
