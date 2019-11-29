class ModelsController < ApplicationController
  include SessionsModule

  def new
    @brand = acc.brands.find(params[:brand_id])
    @model = @brand.models.build
  end

  def create
    @brand = acc.brands.find(params[:brand_id])
    @model = @brand.models.build(model_params)
    if @model.save
      redirect_to @brand
    else
      render 'new'
    end
  end

  def edit
    @brand = acc.brands.find(params[:brand_id])
    @model = @brand.models.find(params[:id])
  end

  def update
    @brand = acc.brands.find(params[:brand_id])
    @model = @brand.models.find(params[:id])
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to @brand }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @brand = acc.brands.find(params[:brand_id])
    @model = @brand.models.find(params[:id])
    @model.trash!
    redirect_to brand_path(@brand)
  end

  private
  def model_params
    params.require(:model).permit(:description)
  end
end
