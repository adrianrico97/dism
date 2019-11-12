class Brand < ApplicationRecord
  belongs_to :account

  has_many :models

  validates_presence_of :description
end
