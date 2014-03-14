FactoryGirl.define do
  factory :user do
    name     "Kemal Akkoyun"
    email    "kakkoyun@gmail.com"
    password "foobarbaz"
    password_confirmation "foobarbaz"
  end
end
