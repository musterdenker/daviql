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
    res << "width: #{layout[:width]}px;" unless layout[:width].blank? || layout[:width] == 0
    res << "height: #{layout[:height]}px;" unless layout[:height].blank? || layout[:height] == 0
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

  def bar_canvas query, layout
    tag = "<canvas id='barchart-#{@query.id}'"
    tag = "#{tag} width=#{@layout[:width]}" unless layout[:width].blank? || layout[:width] == 0
    tag = "#{tag} height=#{@layout[:height]}" unless layout[:height].blank? || layout[:height] == 0
    "#{tag}/>"
  end

  def conditional_width layout
    if layout[:width].to_i > 0
      "width: 100%"
    else
      ""
    end
  end

  def query_jump_options

  end

end
