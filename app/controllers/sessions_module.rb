module SessionsModule

  def self.included(base)
    base.helper_method :current_user_can?
    base.before_action :require_login, :set_locale, :verify_access
  end

  # Definimos según controlador e acción si cada tipo de usuario ten acceso
  # No caso de teño devolve true e en caso engativo false
  def current_user_can?(controller, action)
    can_access = case controller
    when "users"
      # Un usuario pode modificar alguns datos so seu usuario. Controlamos isto na vista de edit
      if action == "edit" || action == "update"
        true
      else
        current_user.admin?
      end
    when "brands", "models", "programs"
      current_user.admin? || current_user.technician?
    when "devices"
      if action == "show"
        true
      else
        current_user.admin? || current_user.technician?
      end
    when "accounts"
      if action == "edit" || action == "update"
        current_user.admin?
      else
        true
      end
    else
      true
    end
    can_access
  end

  private
  def logged_in?
    # Compróbase que o usuario iniciase sesión e estea activo
    !current_user.nil? && current_user.active?
  end

  def require_login
     unless logged_in?
        redirect_to login_path
     end
  end

  def set_locale
    if current_user
      I18n.locale = current_user.locale || I18n.default_locale
    else
      super
    end
  end

  def verify_access
    # Comprobamos si un usuario pode acceder a acción que lle pasamos.
    # No caso de non poder acceder redirixímolo a home
    unless current_user_can?(controller_name, action_name)
      flash[:error] = I18n.t('errors.not_have_access')
      redirect_to home_index_path
    end
  end

end
