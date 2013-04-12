class Interpreter::BaseController < ApplicationController

	def show
		@query = get_query

		@data = @query.execute

		respond_to do |format|
			format.html
			format.csv { 
	 		  	csv = CSV.generate do |csv|
				    csv << @data.first.to_a.map(&:first)
				    @data.each do |e|
				      csv << e.values
				   	 end
				  end
				send_data csv
			}
		end

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