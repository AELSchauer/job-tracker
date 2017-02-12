class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category

  def split_description
    self.description.nil? ? [] : self.description.split("\n")
  end
end
