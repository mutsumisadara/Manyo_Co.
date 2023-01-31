FactoryBot.define do
  factory :task do
    title { 'タイトル1' }
    to_do { '内容1' }
    deadline { 2023-01-02 }
    user
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    to_do { '内容2' }
    deadline { 2023-01-03 }
    user
  end

  factory :third_task, class: Task do
    title { 'タイトル3' }
    to_do { '内容3' }
    deadline { 2023-01-01 }
    user
  end
end