module FacadeHelper

  def render_card query
    render partial: "interpreter/#{query.interpreter}/card", locals: {query: query}
  end


end