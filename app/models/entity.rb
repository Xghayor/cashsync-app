class Entity < ApplicationRecord
  belongs_to :author, foreign_key: "author_id"
  has_many :groups
  
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def most_recent_entities()
    order(created_at: :desc).limit(5)
  end
end
