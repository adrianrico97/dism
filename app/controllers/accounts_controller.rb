class AccountsController < ApplicationController

  def new
    render :layout => false
  end

  def create
    Account.transaction do
      # Crear conta
      account = Account.new
      account.description = params[:description]
      if account.valid?
        account.save!
        # Si a conta é valida crease o usuario
        user = account.reload.users.build(:active => true, :rol => ROLES[:admin])
        user.login = params[:username]
        user.password = params[:password]
        user.email = params[:email]
        user.name = params[:name]
        user.surname_1 = params[:surname_1]
        user.surname_2 = params[:surname_2]
        user.id_document_number = params[:id_document_number]
        if user.valid?
          user.save!
          redirect_to root_path
        else
          # Si o usuario non é válido eliminamos a conta que creamos arriba
          account.trash!
          flash.now[:alert] = user.errors.full_messages.join(', ')
          render "new", :layout => false
        end
      else
        flash.now[:alert] = account.errors.full_messages.join(', ')
        render "new", :layout => false
      end
      
    end
  end

end
