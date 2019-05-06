# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint           not null, primary key
#  comments   :text
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint
#
# Indexes
#
#  index_feedbacks_on_client_id  (client_id)
#

class Feedback < ApplicationRecord
  belongs_to :client

  enum rating: { unfilled: 0, positive: 1, negative: 2, neutral: 3 }, _prefix: :rating
end
