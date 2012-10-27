class Interpreter::BaseController < ApplicationController

	def show
		@query = Query.find params[:id]
		@data = @query.execute
	end

end