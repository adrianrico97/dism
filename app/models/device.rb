class Device < ApplicationRecord
  belongs_to :account
  belongs_to :model
  belongs_to :brand

  has_many :devices_users_relations
  has_many :users, through: :devices_users_relations

  has_and_belongs_to_many :programs

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :description

  validate :device_assigned_to_only_one_user_at_the_same_time

  #########################################
  # MËTODOS DE INSTANCIA                  #
  #########################################
  def associate_user(user, date = Date.today)
    self.devices_users_relations.create!(
      :assignment_date => date,
      :user => user
    )
  end

  def deassociate_user(user, date = Date.today)
    user_relation = self.devices_users_relations.detect{|dur| dur.active? && dur.user.id == user.id }
    (user_relation.present? ? user_relation.update_attributes(:deassignment_date => date) : false )
  end

  def current_user
    self.devices_users_relations.detect{|x| x.active? }.try(:user)
  end

  #########################################
  # MËTODOS PRIVADOS                      #
  #########################################
  private
  def device_assigned_to_only_one_user_at_the_same_time
    if self.devices_users_relations.select{|dur| dur.active? && dur.user.id == user.id }.count > 1
      false
    else
      true
    end
  end
end
