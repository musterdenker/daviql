class QueriesController < ApplicationController
  def create
    query = Query.find(query_params["query_id"])
    redirect_to(action: 'show', controller: "interpreter/#{query.interpreter}", id: query.id)
  end

  private

  def query_params
    params.permit(:query_id)
  end
end
