class Interpreter::DatatableController < Interpreter::BaseController

	def show
		@query = Query.find params[:id]
		@data = @query.execute
	end

end