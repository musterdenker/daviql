class Interpreter::PieController < Interpreter::BaseController

  def show
    @query = get_query
    @data = @query.execute

    respond_to do |format|
      format.html {
        @pie_chart = Presenters::Chart::Pie.new(@query, @data)
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
    end

  end

end
