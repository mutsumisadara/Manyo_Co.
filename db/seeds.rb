10.times do |n|
    User.create!(
        name: "mutsumisadara#{n + 1}",
        email: "mutsumisadara#{n + 1}@gmail.com",
        password: "mutsumisadara#{n + 1}",
        password_confirmation: "mutsumisadara#{n + 1}"
    )
end

user = User.create!(
    name: 'adminuser',
    email: 'adminuser@gmail.com',
    password: 'adminuser',
    password_confirmation: 'adminuser',
    admin: true
)

10.times do |n|
    Label.create!(
        name: "label#{n + 1}"
)
end

10.times do |n|
    Task.create!(
        title: "task#{n + 1}",
        to_do: "task to_do#{n + 1}",
        deadline: "2023-01-31",
        status: "完了",
        priority: "高",
        user_id: user.id,
    )
end