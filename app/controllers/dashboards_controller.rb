class DashboardsController < ApplicationController

  def show
    @dashboard = Dashboard.find(params[:id])
    @dashboard.add_usage current_user
    redirect_to root_url unless @dashboard.users.where("id = #{current_user.id}").count > 0
  end

  protected

end
