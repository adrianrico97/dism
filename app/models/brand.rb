class Brand < ApplicationRecord
  belongs_to :account

  has_many :models, dependent: :destroy
  has_many :devices

  #########################################
  # VALIDACIÓNS                           #
  #########################################
  validates_presence_of :description

  # Non ten sentido poder ter marcas co mesmo nome nunha mesma conta
  validates_uniqueness_of :description, :scope => [:account]

  #########################################
  # MËTODOS DE INSTANCIA                  #
  #########################################
  def display_name
    description.to_s
  end

end
