FactoryGirl.define do
  factory :user do
    name     "Kemal Akkoyun"
    email    "kemal@thedumb.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
