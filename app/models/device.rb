class Device < ApplicationRecord
  belongs_to :account
  belongs_to :model, optional: true
  belongs_to :brand, optional: true

  has_many :devices_users_relations, dependent: :destroy
  has_many :users, through: :devices_users_relations
  has_many :issues

  has_and_belongs_to_many :programs

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :description

  validates_uniqueness_of :code, if: -> { code.present? }, :scope => [:account]
  validates_uniqueness_of :description, :scope => [:account]

  validate :device_assigned_to_only_one_user_at_the_same_time

  #########################################
  # MËTODOS DE INSTANCIA                  #
  #########################################
  def display_name
    if code.present?
      "#{code} - #{description}"
    else
      description
    end
  end

  def associate_user(user, date = Date.today)
    self.devices_users_relations.build(
      :assignment_date => date,
      :user => user
    ).save
  end

  def deassociate_user(user, date = Date.today)
    user_relation = self.devices_users_relations.detect{|dur| dur.active? && dur.user.id == user.id }
    (user_relation.present? ? user_relation.update_attributes(:deassignment_date => date) : false )
  end

  def current_user
    self.devices_users_relations.detect{|x| x.active? }.try(:user)
  end

  def current_assignment_date
    self.devices_users_relations.detect{|x| x.active? }.try(:assignment_date)
  end

  def assigned?
    current_user.present?
  end

  def category_name_translated
    I18n.t("global_constants.categories.#{category}") if category
  end

  #########################################
  # MËTODOS DE CLASE                      #
  #########################################
  def self.next_code_to_device(acc)
    (acc.devices.any? && acc.devices.map(&:code).max != "" ? acc.devices.map(&:code).max.succ : "0001")
  end

  #########################################
  # MËTODOS PRIVADOS                      #
  #########################################
  private
  def device_assigned_to_only_one_user_at_the_same_time
    if devices_users_relations.select{|dur| dur.active? }.count > 1
      errors.add(:devices_users_relations, :invalid, message: I18n.t('errors.device_assigned_to_user'))
    end
  end
end
