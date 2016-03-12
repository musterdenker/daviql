require 'database_types'
module ApplicationHelper
  def get_codemirror_mime_type query
    if query.data_source
      DatabaseTypes.all[query.data_source.database_type.to_sym][:"mime-type"]
    else
      "text/x-sql"
    end
  end

  def inline_dimension layout
    res = ""
    res << "width: #{layout[:width]}px;" unless layout[:width].blank?
    res << "height: #{layout[:height]}px;" unless layout[:height].blank?
  end

end
