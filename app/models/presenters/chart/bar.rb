module Presenters
  module Chart
    class Bar

      def initialize(query, data)
        @data = data
        @query = query
      end

      def data
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
          Rails.logger.info "DATA #{a}"
        end

        option = {
            title: @query.name,
            legend: { position: 'bottom', textStyle: { :fontSize => 16} },
            material: true
        }
        GoogleVisualr::Interactive::ColumnChart.new(data_table, option)
      end

    end
  end
end