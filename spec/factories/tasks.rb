FactoryBot.define do
  factory :task do
    title { 'タイトル1' }
    to_do { 'コンテント1' }
    deadline { DateTime.now }
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    to_do { 'コンテント2' }
    deadline { DateTime.tomorrow }
  end

  factory :third_task, class: Task do
    title { 'タイトル3' }
    to_do { 'コンテント3' }
    deadline { DateTime.yesterday }
  end
end