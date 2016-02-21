require 'database_types'
module ApplicationHelper
  def get_codemirror_mime_type query
    DatabaseTypes.all[query.data_source.database_type.to_sym][:"mime-type"]
  end
end
