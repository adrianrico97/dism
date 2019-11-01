class Account < ApplicationRecord
  has_many :users
  has_many :programs
  has_many :brands

  validates :description, length: { minimum: 3 }, presence: true
  
end
