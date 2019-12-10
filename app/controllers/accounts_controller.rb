class AccountsController < ApplicationController
  include SessionsModule

  # No caso de accounts necesitamos acceder sen login a new e a create (para que poidan rexistrarse novos usuarios)
  before_action :require_login, :set_locale, :verify_access, only: [:edit, :update]

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
        user.locale = AVAILABLE_LOCALES[:es_ES]
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

  def edit
    @account = acc
  end

  def update
    @account = acc
    if @account.update(account_params)
      flash[:success] = I18n.t('account.success_updated')
      redirect_to home_index_path
    else
      render 'edit'
    end
  end

  private
  def account_params
    params.require(:account).permit(:description)
  end

end
