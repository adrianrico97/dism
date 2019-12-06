class DevicesUsersRelation < ApplicationRecord
  belongs_to :user
  belongs_to :device

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :assignment_date
  validate :deassignment_date_is_less_than_or_equal_to_today
  validate :device_is_asigned_only_to_one_user
  validate :device_not_was_assigned_at_this_time

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
    if deassignment_date.present?
      unless deassignment_date <= Date.today && deassignment_date >= assignment_date
        errors.add(:deassignment_date, :invalid)
      end
    end
  end

  def device_is_asigned_only_to_one_user
    if device.devices_users_relations.select{|dur| dur.active? }.count > 1
      errors.add(:device, :invalid, message: I18n.t('errors.device_assigned_to_user'))
    end
  end

  # Comprobar que o dispositivo non estivese asignado nese momento
  def device_not_was_assigned_at_this_time
    #TODO revisar
    #if device.devices_users_relations.select{|dur| dur.assignment_date <= assignment_date || (dur.deassignment_date && deassignment_date && dur.deassignment_date >= deassignment_date)}.any?
    if device.devices_users_relations.select{|dur| dur.assignment_date >= assignment_date && (dur.deassignment_date && dur.deassignment_date <= assignment_date) }.any?
      errors.add(:device, :invalid)
    end
  end

end