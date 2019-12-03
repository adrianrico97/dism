class Model < ApplicationRecord
  belongs_to :brand

  has_many :devices

  has_one :account, through: :brand

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :description

  # Non ten sentido poder ter modelos co mesmo nome nunha mesma marca
  validates_uniqueness_of :description, :scope => [:brand]

  #########################################
  # CALLBACKS                             #
  #########################################
  before_destroy :check_for_devices

  #########################################
  # MËTODOS DE INSTANCIA                  #
  #########################################
  def display_name
    description.to_s
  end

  private
  def check_for_devices
    if devices.count > 0
      errors.add(:base, :invalid, message: I18n.t('errors.has_dependencies'))
      return false
    end
  end

end
