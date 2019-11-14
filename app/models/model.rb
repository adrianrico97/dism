class Model < ApplicationRecord
  belongs_to :brand

  has_many :devices

  has_one :account, through: :brand

  validates_presence_of :description
end
