class Program < ApplicationRecord
  belongs_to :account

  has_and_belongs_to_many :devices

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :description

  # Non ten sentido poder ter programas co mesmo nome nunha mesma conta
  validates_uniqueness_of :description, :scope => [:account]

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
      errors.add_to_base(I18n.t('errors.has_dependencies'))
      return false
    end
  end
  
end
