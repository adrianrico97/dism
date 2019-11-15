class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :device

  has_one :account, through: :device

  #########################################
  # SCOPES                                #
  #########################################
  scope :open, -> { where("state = 'open") }
  scope :in_progres, -> { where("state = 'in_progres") }
  scope :closed, -> { where("state = 'closed") }

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :title

end
