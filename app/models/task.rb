class Task < ApplicationRecord
    validates :title, :to_do, presence: true
    enum status: { 未着手: 0, 着手中: 1, 完了: 2}
    enum priority: { 高: 0, 中: 1, 低: 2}

    scope :scope_title, -> (title){ where('title LIKE ?', "%#{title}%") }
    scope :scope_status, -> (status){ where(status: status) }
    scope :scope_label, -> (label_id) {where(id: Labelling.where(label_id: label_id).pluck(:task_id))}
    # Labellingテーブルのカラム、label_idから送られてきたlabel_idに該当するものを取り、.pluckでそれに該当するtask_idを取得
    # Task.whereでその該当するタスクの中身をTaskテーブルから取得

    # scope :scope_label, -> (labelling){ where(id: task_id)}
    # scope :scope_label, -> (label){ Task.joins(:labels).merge(Label.where(label_ids)) }
    # scope :scope_label, -> (label){ Label.joins(:label).where(label: label)}
    # scope :scope_label, -> (label_id){ joins{Task.where(id: task_id).where(label: label_id})}
    # scope :scope_label, -> (label){ where{Task.where(id: task_id)(label: label_id)}

    # scope :scope_label, -> (label_id){ joins(:labels).where(tasks_id: { label: label_id }) }
    belongs_to :user
    
    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings
end
