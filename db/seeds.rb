2.times do |n|
    User.create!(
        name: "sadara#{n + 1}",
        email: "sadaraaaaa#{n + 1}@gmail.com",
        password: "sadaramutsumi#{n + 1}",
        password_confirmation: "sadaramutsumi#{n + 1}"
    )
end

User.create!(
    name: 'admin',
    email: 'admin1@gmail.com',
    password: 'adminuser',
    password_confirmation: 'adminuser',
    admin: true
)