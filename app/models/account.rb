class Account < ApplicationRecord
  has_many :users
  has_many :programs
  has_many :brands
  has_many :devices

  has_many :models, through: :brands
  has_many :issues, through: :devices

  validates :description, length: { minimum: 3 }, presence: true
  
end
