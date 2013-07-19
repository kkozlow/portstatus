class HeadEndsController < ApplicationController
	before_filter :require_user
  
  def index
    @hes = He.order(:address).active.business_mpls.uniq
  end
  
  def show
    @connect_error = false
    @he = He.find(params[:id])
    @ports = @he.ports_state
    if @ports == -1
      @connect_error = true
      flash.now[:error] = "Urzadzenie #{@he.name} #{@he.ip} nie odpowiada \n"
    end
    
    if @current_user.is_admin?
      @list_path = hes_path
    else
      @list_path = switch_index_path
    end
  end
end
