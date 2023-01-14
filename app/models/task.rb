class Task < ApplicationRecord
    validates :title, :to_do, presence: true
    # default_scope -> {order(created_at: :desc)}
    # scope :latest, -> {order(deadline: :desc)}
end
