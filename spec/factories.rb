FactoryGirl.define do
  factory :user do
    name     'Foo Bar Baz'
    email    'foo@bar.com'
    password 'foobarbaz'
    password_confirmation 'foobarbaz'

    factory :admin do
      admin true
    end
  end

  factory :users do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :micropost do
    content 'Lorem ipsum'
    user
  end
end
