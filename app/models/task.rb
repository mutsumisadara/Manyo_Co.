class Task < ApplicationRecord
    validates :title, :to_do, presence: true
end
