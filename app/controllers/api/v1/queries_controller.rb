module Api::V1
  class QueriesController < ApiController

    def show
      begin
        query = Query.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render_not_found and return
      end

      unless params[:auth_token] == query.auth_token
        render_unauthorized and return
      end
      data = query.execute

      render json: data
    end

  end
end