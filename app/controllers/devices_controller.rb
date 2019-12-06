class DevicesController < ApplicationController
  include SessionsModule

  def index
    @devices = acc.devices
  end

  def show
    @device = acc.devices.find(params[:id])
  end

  def new
    @device = acc.devices.build
  end

  def create
    @device = acc.devices.build(devices_params)
    unless @device.code.present?
      @device.code = Device.next_code_to_device(@device.account)
    end
    if @device.save
      redirect_to @device
    else
      render 'new'
    end
  end

  def models_for_select_brand
    @brand = acc.brands.find(params[:brand_id])
    @models = @brand.models
    respond_to do |format|
      format.json { render json: @models }
    end
  end

  def edit
    @device = acc.devices.find(params[:id])
  end

  def update
    @device = acc.devices.find(params[:id])
    respond_to do |format|
      if @device.update(devices_params)
        format.html { redirect_to @device }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @device = acc.devices.find(params[:id])
    @device.trash!
    redirect_to devices_path
  end

  def assign
    @device = acc.devices.find(params[:id])
  end

  def save_assign
    @device = acc.devices.find(params[:device_id])
    date = Date.parse(params[:date])
    user = acc.users.actives.find(params[:user_id])
    respond_to do |format|
      if @device.associate_user(user, date)
        flash[:success] = I18n.t('devices.assign_to_user_success')
        format.html { redirect_to @device }
      else
        flash[:error] = I18n.t('devices.assign_to_user_error')
        format.html { render :assign }
      end
    end
  end

  def deassign
    @device = acc.devices.find(params[:id])
  end

  def save_deassign
    @device = acc.devices.find(params[:device_id])
    date = Date.parse(params[:date])
    user = acc.users.actives.find(params[:user_id])
    respond_to do |format|
      if @device.deassociate_user(user, date)
        flash[:success] = I18n.t('devices.deassign_to_user_success')
        format.html { redirect_to @device }
      else
        flash[:error] = I18n.t('devices.deassign_to_user_error')
        format.html { render :deassign }
      end
    end
  end

  private
  def devices_params
    params.require(:device).permit(:description, :observations, :serial_number, 
      :code, :category, :price, :purchase_date, :model_id, :brand_id)
  end
end
