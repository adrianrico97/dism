class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :device

  has_one :account, through: :device

  has_many :trackings, dependent: :destroy

  #########################################
  # SCOPES                                #
  #########################################
  scope :open, -> { where("state = 'open'") }
  scope :in_progress, -> { where("state = 'in_progress'") }
  scope :closed, -> { where("state = 'closed'") }
  scope :not_closed, -> { where("state NOT LIKE 'closed'") }
  scope :for_user, -> (user) { where('user_id = ?', user.id) }

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :title, :date, :state, :priority

  validates :state, inclusion: ISSUE_STATES.values
  validates :priority, inclusion: ISSUE_PRIORITIES.values

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

  def priority_translated
    I18n.t("global_constants.issue_priorities.#{priority}") if priority
  end

  def state_translated
    I18n.t("global_constants.issue_states.#{state}") if state
  end

end
