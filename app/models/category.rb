class Category < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  has_many :jobs

  def self.drop_down_list
    order(:title).pluck(:title, :id)
  end
end
