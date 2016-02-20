module FacadeHelper

	def list_icon interpreter
		case interpreter
		when 'datatable'
			'icon-list-alt'
		when 'graph'
			'icon-signal'
		end
	end

  def render_card query
    render partial: "interpreter/#{query.interpreter}/card", locals: {query: query}
  end


end