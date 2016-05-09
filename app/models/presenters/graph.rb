module Presenters
  class Graph < Base

    def data
      data_table = GoogleVisualr::DataTable.new

      data_table.new_column('string', "")

      values = []
      @data.first.to_a[1..-1].each do |element|
        values << element.first
        data_table.new_column('number', element.first)
      end

      @data.each do |d|
        a = []
        a << d['group_column']
        values.each do |key|
          a << d[key].to_f
        end

        data_table.add_row a
      end

      options = {
          title: @query.name,
          legend: { position: 'bottom', textStyle: { :fontSize => 16} },
          material: true,
          width: @layout[:width],
          height: @layout[:height]
      }

      GoogleVisualr::Interactive::ColumnChart.new(data_table, options)
    end

  end
end
