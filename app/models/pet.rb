class Pet < ActiveRecord::Base
  validates :human, presence: true
  validates :name, presence: true, uniqueness: { scope: :human }

  def self.search(query)
    self.where("name like ?", "%" + query + "%")
  end
end
