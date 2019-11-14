class Brand < ApplicationRecord
  belongs_to :account

  has_many :models
  has_many :devices

  validates_presence_of :description
end
