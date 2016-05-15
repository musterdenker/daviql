class Interpreter::BaseController < ApplicationController

	def show
		@query = get_query

		@layout = get_layout

    @dynamic_fields = params[:dynamic_fields]

		@data = @query.get_data @dynamic_fields

		respond_to do |format|
      format.html {
        if enough_rights?
          @data_to_present = (@query.presenter).constantize.new(@query, @data, @layout)
          render "interpreter/show"
        else
          redirect_to root_path
        end
      }
      format.csv {
        csv = CSV.generate do |csv|
          csv << @data.first.to_a.map(&:first)
          @data.each do |e|
            csv << e.values
          end
        end
        send_data csv
      }
      format.js{
        @data_to_present = @query.presenter.constantize.new(@query, @data, @layout)
        render  "interpreter/show"
      }

		end

	end

	protected

  def enough_rights?
    get_query.users.where("id = #{current_user.id}").count > 0
  end

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
		q = Query.find params[:id] #, current_user.id
		if q.nil?
			#refcator, not working with ajax
			redirect_to :root
		end
		q
	end

end
