class HesController < ApplicationController
	before_filter :require_user
  before_filter :verify_admin, :except=>[:index, :show]
  
  def index
    if is_admin(@current_user)
      @hes = He.find(:all, :order => "address ASC")
    else
      @he_ids = @current_user.devices.collect{|device| device.he_id}.uniq
      @hes = He.find(@he_ids)
    end
  
    @admin = is_admin(@current_user)
  end
  
  def new
    @new_he = He.new()
  end
  
  def show
    @he = He.find(params[:id])
    if is_admin(@current_user)
      @devices = @he.devices
    else
      @devices = @current_user.devices.where(:he_id => @he)
    end
    

    @admin = is_admin(@current_user)
  end

  def create
    @new_he = He.new(params[:he])
    if @new_he.save
      flash[:notice] = "Pomyslnie dodano HE"
      redirect_to :action => "index"
    else
      flash[:error] = "Wystapil blad podczas dodawania HE"
      redirect_to :back
    end
  end
  
  def edit
    @he = He.find(params[:id])
  end
  
  def update
    @he = He.find(params[:id])
      if @he.update_attributes(params[:he])
        flash[:notice] = "Zaktualizowano HE"
        redirect_to :action => 'index'
      else
        flash[:notice] = "HE nie zostalo zaktualizowane"
        render :action => 'edit'
      end
  end
  
  def destroy
    if He.destroy(params[:id])
      flash[:notice] = "Pomyslnie usunieto HE"
    else
      flash[:error] = "Wystapil blad podczas usuwania HE"
    end
    redirect_to :action => "index"
  end
end
