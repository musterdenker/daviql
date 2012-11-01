module FacadeHelper

	def list_icon interpreter
		case interpreter
		when 'datatable'
			'icon-list-alt'
		when 'graph'
			'icon-signal'	
		end
	end

end