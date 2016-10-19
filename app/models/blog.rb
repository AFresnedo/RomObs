class Blog < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
  validates :descript, presence: true, length: { maximum: 200 }
  # retrieve blogs from DB in descending order of creation
  default_scope -> { order(created_at: :desc) }
end
