class Tracking < ApplicationRecord
  belongs_to :issue
  belongs_to :user

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :description

end
