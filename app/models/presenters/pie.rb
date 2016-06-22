module Presenters
  class Pie < Base

    def data

      data_table = GoogleVisualr::DataTable.new

      data_table.new_column('string', 'Label')
      data_table.new_column('number', 'Number')

      data_table.add_rows(get_data_rows)

      @layout[:height] = 500 if @layout[:height].blank?

      option = {
          legend: {position: 'right', textStyle: {:fontSize => 16}},
          material: false,
          height: "500"
      }
      GoogleVisualr::Interactive::PieChart.new(data_table, option)
    end

    def debug
      @data.values.inspect
    end

    def get_data_rows
      case @query.data_source.database_type
        when 'postgresql'
          values = []
          @data.each do |val|
            values << [val['label'], val['number'].to_i]
          end
          values
        when 'mysql'
          values = []
          @data.each do |val|
            values << [val['label'], val['number'].to_i]
          end
          values
      end
    end

  end
end
