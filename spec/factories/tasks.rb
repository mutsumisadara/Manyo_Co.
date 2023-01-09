FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    to_do { 'Factoryで作ったデフォルトのコンテント１' }
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    to_do { 'Factoryで作ったデフォルトのコンテント２' }
  end
end