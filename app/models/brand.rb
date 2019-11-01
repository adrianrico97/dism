class Brand < ApplicationRecord
  belongs_to :account

  validates_presence_of :description
end
