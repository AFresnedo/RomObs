class Blog < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  # TODO length
  validates :descript, presence: true
  # retrieve blogs from DB in descending order of creation
  default_scope -> { order(created_at: :desc) }
end
