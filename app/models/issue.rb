class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :device

  has_one :account, through: :device

  has_many :trackings, dependent: :destroy

  #########################################
  # SCOPES                                #
  #########################################
  scope :open, -> { where("state = 'open") }
  scope :in_progress, -> { where("state = 'in_progress") }
  scope :closed, -> { where("state = 'closed") }

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :title, :date, :state, :priority

  #########################################
  # MËTODOS DE INSTANCIA                  #
  #########################################
  def open?
    state == ISSUE_STATES[:open]
  end

  def in_progress?
    state == ISSUE_STATES[:in_progress]
  end

  def closed?
    state == ISSUE_STATES[:closed]
  end

end
