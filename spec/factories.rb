FactoryGirl.define do
  factory :user do
    name     "Foo Bar Baz"
    email    "foo@bar.com"
    password "foobarbaz"
    password_confirmation "foobarbaz"
  end
end
