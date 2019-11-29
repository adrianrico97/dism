class Account < ApplicationRecord
  has_many :users
  has_many :programs
  has_many :brands
  has_many :devices

  has_many :models, through: :brands
  has_many :issues, through: :devices

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates :description, length: { minimum: 3 }, presence: true

  #########################################
  # CALLBACKS                             #
  #########################################
  before_destroy :check_for_dependencies

  private
  def check_for_dependencies
    if (devices.count > 0 || users.count > 0 || models.count > 0 || brands.count > 0 ||
      programs.count > 0 || issues.count > 0)
      errors.add(I18n.t('errors.has_dependencies'))
      return false
    end
  end
  
end
