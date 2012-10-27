class Interpreter::GraphController < Interpreter::BaseController

	def show
		@query = Query.find params[:id]
		@data = @query.execute
		data_table = GoogleVisualr::DataTable.new

		xaxis = @data.first.to_a.first.first

		data_table.new_column('date', xaxis)

		values = []
		@data.first.to_a[1..-1].each do |element|
			values << element.first
			data_table.new_column('number', element.first)
		end

		@data.each do |d|
			a = []
			a << d[xaxis]
			values.each do |key|
				a << d[key]
			end
			data_table.add_row a
			logger.info "DATA #{a}"
		end

		option = { :width => 2000, :height => 400, :title => @query.name }
		@chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)


	end

end