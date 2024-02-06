class Group < ApplicationRecord
  belongs_to :user
  has_many :entities

  validates :name, presence: true
  validates :icon, presence: true

  def total_transactions_amount
    entities.sum(:amount)
  end
end
