FactoryGirl.define do
  factory :friendship do
    # user nil
    association :user, factory: :user # se crea un modelo usuario para cada una de las asociaciones
    # friend nil
    association :friend, factory: :user  # se crea un modelo usuario para cada una de las asociaciones
    status "MyString"
  end
end
