class Pet < ActiveRecord::Base
  validates :human, presence: true
  validates :name, presence: true, uniqueness: { scope: :human }
end
