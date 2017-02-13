class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments

  def split_description
    self.description.nil? ? [] : self.description.split("\r\n").reject { |p| p.empty? }
  end

  def category_title
    self.category.nil? ? "" : self.category.title
  end

  def self.query(params)
    if params.empty?
      { "" => order(:title) }
    elsif params[:sort]
      order(:title).group_by { |job| job[params[:sort]] }
    elsif params[:city]
      { params[:city] => where(city: params[:city]).order(:title) }
    end
  end
end
