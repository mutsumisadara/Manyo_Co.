class Task < ApplicationRecord
    validates :title, :to_do, presence: true
    enum status: { 未着手: 0, 着手中: 1, 完了: 2}
    enum priority: { 高: 0, 中: 1, 低: 2}

    # scope :scope_both, -> (title, status){ where('title LIKE ?', "%#{title}%").where('status: status', "#{status}")}
    scope :scope_title, -> (title){ where('title LIKE ?', "%#{title}%") }
    scope :scope_status, -> (status){ where(status: status) }
end
