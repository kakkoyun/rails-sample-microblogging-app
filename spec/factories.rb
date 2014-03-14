FactoryGirl.define do
  factory :user do
    name     "Foo Bar Baz"
    email    "foo@bar.com"
    password "foobarbaz"
    password_confirmation "foobarbaz"
  end

  factory :another_user do
    name     "Foo Baz"
    email    "baz@bar.com"
    password "foobarbaz"
    password_confirmation "foobarbaz"
  end
end
