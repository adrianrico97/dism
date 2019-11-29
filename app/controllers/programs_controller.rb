class ProgramsController < ApplicationController
  include SessionsModule

  def index
    @programs = acc.programs
  end

  def show
    @program = acc.programs.find(params[:id])
  end

  def new
    @program = acc.programs.build
  end

  def create
    @program = acc.programs.build(programs_params)
    if @program.save
      redirect_to @program
    else
      render 'new'
    end
  end

  def edit
    @program = acc.programs.find(params[:id])
  end

  def update
    @program = acc.programs.find(params[:id])
    respond_to do |format|
      if @program.update(programs_params)
        format.html { redirect_to @program }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @program = acc.programs.find(params[:id])
    @program.trash!
    redirect_to programs_path
  end

  private
  def programs_params
    params.require(:program).permit(:description, :version, :observations)
  end

end
