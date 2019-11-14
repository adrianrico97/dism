class Program < ApplicationRecord
  belongs_to :account

  has_and_belongs_to_many :devices

  validates_presence_of :description
  
end
