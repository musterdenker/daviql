require 'database_types'
module ApplicationHelper
  def get_codemirror_mime_type query
    if query.data_source
      DatabaseTypes.all[query.data_source.database_type.to_sym][:"mime-type"]
    else
      "text/x-sql"
    end
  end

  def inline_dimension query
    res = ""
    res << "width: #{query.width}px;" unless query.width.blank?
    res << "height: #{query.height}px;" unless query.height.blank?
  end

end
