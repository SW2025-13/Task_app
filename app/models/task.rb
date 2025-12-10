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

>>>>>>> a7932999b16f79d36c9c74fa2e22b0c402a012a3
end
