class Account < ApplicationRecord
  has_many :users

  validates :description, length: { minimum: 3 }, presence: true
  
end
