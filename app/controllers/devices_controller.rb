class DevicesController < ApplicationController
  
  before_filter :require_user
  before_filter :deny_biznes
  before_filter :verify_admin
  
  def index
    @devices = Device.find(:all, :order => "name ASC")
  end
  
  def new
    @new_device = Device.new()
    @hes = He.find(:all, :order => "address ASC")
  end
  
  def create
    @new_device = Device.new(params[:device])
    if @new_device.save
      flash[:notice] = "Pomyslnie dodano urzadzenie"
      redirect_to :action => "index"
    else
      flash[:error] = "Wystapil blad podczas dodawania urzadzenia"
      redirect_to :back
    end
  end
  
  def edit
    @hes = He.find(:all, :order => "address ASC")
    @device = Device.find(params[:id])
  end
  
  def update
    @device = Device.find(params[:id])
      if @device.update_attributes(params[:device])
        flash[:notice] = "Zaktualizowano urzadzenie"
        redirect_to :back
      else
        flash[:notice] = "Urzadzenie nie zostalo zaktualizowane"
        render :action => 'edit'
      end
  end
  
  def destroy
    if Device.destroy(params[:id])
      flash[:notice] = "Pomyslnie usunieto urzadzenie"
    else
      flash[:error] = "Wystapil blad podczas usuwania urzadzenia"
    end
    redirect_to :back
  end
end
