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

  private
  def devices_params
    params.require(:device).permit(:description, :observations, :serial_number, 
      :code, :category, :price, :purchase_date, :model_id, :brand_id)
  end
end
