2.times do |n|
    User.create!(
        name: "sadara#{n + 1}",
        email: "sadara#{n + 1}@gmail.com",
        password: "sadaramutsumi#{n + 1}",
        password_confirmation: "sadaramutsumi#{n + 1}"
    )
end