# FactoryGirl.define do
#   factory :user do
#     name     'Foo Bar Baz'
#     email    'foo@bar.com'
#     password 'foobarbaz'
#     password_confirmation 'foobarbaz'
#   end
# end

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password 'foobar'
    password_confirmation 'foobar'
  end
end
