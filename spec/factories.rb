FactoryGirl.define do
  factory :user do
    name     "Kemal Akkoyun"
    email    "kakkoyun@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
