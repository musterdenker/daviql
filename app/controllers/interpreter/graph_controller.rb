class Interpreter::GraphController < Interpreter::BaseController

	def show
		@query = get_query
		@data = @query.execute

		respond_to do |format|
			format.html {
				data_table = GoogleVisualr::DataTable.new

				xaxis = @data.first.to_a.first.first

				data_table.new_column('string', xaxis)

				values = []
				@data.first.to_a[1..-1].each do |element|
					values << element.first
					data_table.new_column('number', element.first)
				end

				@data.each do |d|
					a = []
					a << d[xaxis]
					values.each do |key|
						a << d[key].to_f
					end
					data_table.add_row a
					logger.info "DATA #{a}"
				end

				option = { :width => 2000, :height => 400, :title => @query.name, :legend => {:position => 'top', :textStyle => { :fontSize => 16}} }
				@chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
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
		end

		end

end