2.times do |n|
    User.create!(
        name: "mutsumisadara#{n + 1}",
        email: "mutsumisadara#{n + 1}@gmail.com",
        password: "mutsumisadara#{n + 1}",
        password_confirmation: "mutsumisadara#{n + 1}"
    )
end

User.create!(
    name: 'adminuser',
    email: 'adminuser@gmail.com',
    password: 'adminuser',
    password_confirmation: 'adminuser',
    admin: true
)