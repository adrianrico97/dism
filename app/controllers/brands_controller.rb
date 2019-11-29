class BrandsController < ApplicationController
  include SessionsModule

  def index
    @brands = acc.brands
  end

  def show
    @brand = acc.brands.find(params[:id])
  end

  def new
    @brand = acc.brands.build
  end

  def create
    @brand = acc.brands.build(brand_params)
    if @brand.save
      redirect_to @brand
    else
      render 'new'
    end
  end

  def edit
    @brand = acc.brands.find(params[:id])
  end

  def update
    @brand = acc.brands.find(params[:id])
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @brand = acc.brands.find(params[:id])
    @brand.trash!
    redirect_to brands_path
  end

  private
  def brand_params
    params.require(:brand).permit(:description)
  end

end
