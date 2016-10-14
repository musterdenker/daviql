class FacadeController < ApplicationController
  def start
    @queries = Query.joins(:users).where("users.id = #{current_user.id}")
    @dashboards = Dashboard.joins(:users).where("users.id = #{current_user.id}")
  end
end
