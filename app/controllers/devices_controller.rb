class DevicesController < ApplicationController
  
  before_filter :require_user
  before_filter :deny_hebiznes
  before_filter :verify_admin
  
  def index
    #@devices = Device.find(:all, :order => "name ASC")
    @hes = He.order(:address)
  end
  
  def new
    @device = Device.new()
    @hes = He.order{address.desc}
    users_to_exclude = ['admin', 'admin2', 'hebiznes']
    @users = User.where("username NOT IN (?)", users_to_exclude)
  end
  
  def create
    @device = Device.new(params[:device])
    if @device.save
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
    users_to_exclude = ['admin', 'admin2', 'hebiznes']
    @users = User.where("username NOT IN (?)", users_to_exclude)
  end
  
  def update
    params[:device][:user_ids] ||= []
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
