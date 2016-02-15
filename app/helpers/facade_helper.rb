module FacadeHelper

	def list_icon interpreter
		case interpreter
		when 'datatable'
			'fa fa-list-alt'
		when 'graph'
			'fa fa-bar-chart'
		end
	end

end