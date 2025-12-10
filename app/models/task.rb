class Task < ApplicationRecord
  validates :title, presence: true
  validates :deadline, presence: true

  validates :effort,
            numericality: {
              allow_nil: true,
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            }

  validates :priority,
            numericality: {
              allow_nil: true,
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            }

end
