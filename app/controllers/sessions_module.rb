module SessionsModule

  def self.included(base)
    base.before_action :require_login, :set_locale
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

end