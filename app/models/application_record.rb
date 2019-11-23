class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def trash!
    self.destroy!
  end
end
