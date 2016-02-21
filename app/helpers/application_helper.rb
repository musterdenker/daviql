module ApplicationHelper
  def get_codemirror_mime_type query
    if query.data_source
      DatabaseTypes.all[query.data_source.database_type.to_sym][:"mime-type"]
    else
      "text/x-sql"
    end
  end
end
