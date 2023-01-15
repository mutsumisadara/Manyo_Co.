class Task < ApplicationRecord
    validates :title, :to_do, presence: true
    enum priority: { 高: 0, 中: 1, 低: 2}
    # default_scope -> {order(created_at: :desc)}
    # scope :latest, -> {order(deadline: :desc)}
end
