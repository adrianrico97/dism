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
    if @brand.update(brand_params)
      redirect_to @brand
    else
      redirect_to 'edit'
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
