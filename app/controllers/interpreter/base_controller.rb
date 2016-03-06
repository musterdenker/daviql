class Interpreter::BaseController < ApplicationController

	def show
		@query = get_query

		@data = @query.execute

		respond_to do |format|
			format.html {
				render "interpreter/show"
			}
			format.csv {
				send_csv @data
			}
			format.js{
				render  "interpreter/show"
			}
		end

	end

	protected

	def send_csv data
	  	csv = CSV.generate do |csv|
		    csv << data.first.to_a.map(&:first)
		    data.each do |e|
		      csv << e.values
		   	 end
		  end
		send_data csv
	end

	def get_query
		q = Query.find_restricted params[:id], current_user.id
		if q.nil?
			redirect_to :root
		end
		q
	end

end