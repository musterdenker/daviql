class Interpreter::PieController < Interpreter::BaseController

  def show
    @query = get_query
    @layout = get_layout
    @data = @query.get_data

    respond_to do |format|
      format.html {
        @pie_chart = Presenters::Chart::Pie.new(@query, @data, @layout)
        render "interpreter/show"
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
        @pie_chart = Presenters::Chart::Pie.new(@query, @data, @layout)
        render  "interpreter/show"
      }
    end

  end

end
