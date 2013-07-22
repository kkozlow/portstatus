class SwitchController < ApplicationController
  
  before_filter :require_user
  before_filter :deny_hebiznes
  
  def index
    he_ids = @current_user.devices.collect{|dev| dev.he_id}.uniq
    @hes = He.find(he_ids)
    #  @devices = @current_user.devices.find(:all, :order => "name ASC") 
    #  @hes = He.order(:address)
  end
  
  def new

  end
  
  def show
    @connect_error = false
    @device = Device.find(params[:id])
    @ports = @device.ports_state
    if @ports == -1
      @connect_error = true
      flash.now[:error] = "Urzadzenie #{@device.name} #{@device.ip} nie odpowiada \n"
    end
    
    if @current_user.is_admin?
      @list_path = devices_path
    else
      @list_path = switch_index_path
    end
  end
end
