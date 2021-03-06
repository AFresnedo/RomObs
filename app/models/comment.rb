class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  validates :body, presence: true, length: { maximum: 2000 }
  default_scope -> { order(created_at: :desc) }
end
