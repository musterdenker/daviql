class FacadeController < ApplicationController

def start
  @queries = Query.joins(:users).where("users.id = #{current_user.id}")
  @dashboards = Dashboard.all
end

end