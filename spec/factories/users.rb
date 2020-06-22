FactoryGirl.define do
  factory :user do
    password "12345678"
    sequence(:email){|n|"dummy_#{n}@factory.com"}
  end
end
