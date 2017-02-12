class Contact < ActiveRecord::Base
  validates :first_name, :last_name, :position, :email, presence: true
  validates :email, uniqueness: true
  belongs_to :company

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
