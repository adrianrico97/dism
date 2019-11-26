class User < ApplicationRecord
  belongs_to :account

  has_many :devices_users_relations
  has_many :devices, through: :devices_users_relations
  has_many :issues
  has_many :trackings

  #########################################
  # VALIDACIÓNS                           #
  #########################################  
  has_secure_password :password, validations: false

  validates_presence_of :login, :password_digest, :name, :surname_1, :email, :rol
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email, :login, case_sensitive: true
  validates :rol, inclusion: ROLES.values

  #########################################
  # MËTODOS DE INSTANCIA                  #
  #########################################
  def active_devices
    devices_users_relations.select{|x| x.active? }.map(&:device)
  end

  def full_name
    [name, surname_1, surname_2].join(" ")
  end

end