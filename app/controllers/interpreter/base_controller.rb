class Interpreter::BaseController < ApplicationController

	def show
		@query = get_query

		@data = @query.execute
	end

	protected 

	def get_query
		q = Query.find_restricted params[:id], current_user.id
		if q.nil?
			redirect_to :root
		end
		q
	end

end