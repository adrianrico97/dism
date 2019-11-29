class UsersController < ApplicationController
  include SessionsModule

  def index
    @users = acc.users
  end

  def show
    @user = acc.users.find(params[:id])
  end

  def new
    @user = acc.users.new
  end

  def create
    @user = acc.users.build(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = acc.users.find(params[:id])
  end

  def update
    @user = acc.users.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def activate
    @user = acc.users.find(params[:id])
    @user.update_attributes! :active => true
    redirect_to @user
  end

  def deactivate
    @user = acc.users.find(params[:id])
    @user.update_attributes! :active => false
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit(:login, :email, :password, :name, 
      :surname_1, :surname_2, :id_document_number, :rol, :locale)
  end

end