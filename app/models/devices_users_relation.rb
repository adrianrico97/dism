class DevicesUsersRelation < ApplicationRecord
  belongs_to :user
  belongs_to :device

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :assignment_date
  validate :deassignment_date_is_less_than_or_equal_to_today
  validate :device_is_asigned_only_to_one_user

  #########################################
  # MËTODOS DE INSTANCIA                  #
  #########################################
  def active?
    !deassignment_date.present?
  end

  #########################################
  # MËTODOS PRIVADOS                      #
  #########################################
  private
  def deassignment_date_is_less_than_or_equal_to_today
    # A data de desasignación debe ser igual ou anterior a hoxe
    deassignment_date.present? ? deassignment_date <= Date.today : true
  end

  def device_is_asigned_only_to_one_user
    if device.devices_users_relations.select{|dur| dur.active? }.count > 1
      errors.add(:device, :invalid, message: I18n.t('errors.device_assigned_to_user'))
    end
  end

end