class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :deadline, presence: true       

  validates :priority, inclusion: { in: 1..5 }
  validates :effort, inclusion: { in: 1..5 }
end
