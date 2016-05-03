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

  def image_or_placeholder(image_url)
    image_url || image_path('fallbacks/retina_thumb_profile_image.png')
  end

  def name_or_email(user)
    name_or_email = user.full_name
    if name_or_email.blank?
      name_or_email = user.email
    end
    name_or_email
  end

  def conditional_width layout
    if layout[:width].to_i > 0
      "width: #{layout[:width]}px"
    else
      ""
    end
  end

end
