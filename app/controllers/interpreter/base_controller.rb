class Interpreter::BaseController < ApplicationController

	def show
		@query = get_query

		@data = @query.get_data

		@layout = get_layout

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

	def get_layout
		layout = {
			width: @query.width,
			height: @query.height
		}
		if params[:width]
			layout[:width] = params[:width]
		end

		if params[:height]
			layout[:height] = params[:height]
		end
		layout
	end

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
			#refcator, not working with ajax
			redirect_to :root
		end
		q
	end

end