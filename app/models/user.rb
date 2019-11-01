class User < ApplicationRecord
  has_secure_password :password, validations: false

  validates_presence_of :login, :password_digest, :name, :surname_1, :email, :rol
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email, :login, case_sensitive: true
  validates :rol, inclusion: ROLES.values

end