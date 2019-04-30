class Feedback < ApplicationRecord
  belongs_to :client

  enum rating: { unfilled: 0, positive: 1, negative: 2, neutral: 3 }, _prefix: :rating
end
