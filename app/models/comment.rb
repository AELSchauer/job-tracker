class Comment < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :job

  def split_content
    self.content.nil? ? [] : self.content.split("\r\n\r\n").reject { |p| p.empty? }
  end
end
