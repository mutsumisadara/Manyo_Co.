FactoryBot.define do
  factory :user do
    name { "sadara" }
    email { "sadara_1@gmail.com"}
    password { "sadaramutsumi" }
    password_confirmation { "sadaramutsumi" }
    # name { "111@gmail.com" }
    # email { "111@gmail.com" }
    # password { "111@gmail.com" }
    # password_confirmation { "111@gmail.com" }
    # # task { nil }
    admin {true}
  end

  factory :second_user, class: User do
    name { "sadara" }
    email { "sadara_2@gmail.com"}
    password { "sadaramutsumi" }
    password_confirmation { "sadaramutsumi" }
    # name { "222@gmail.com" }
    # email { "222@gmail.com" }
    # password { "222@gmail.com" }
    # password_confirmation { "222@gmail.com" }
    # # task { nil }
    admin {false}
  end
end