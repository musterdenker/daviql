FactoryGirl.define do
  factory :query do
    data_source
    name "MyName"
    body "select 1"
    description "Some description"

    trait :datatable do
      interpreter "datatable"
    end

    trait :graph do
      interpreter "graph"
    end

  end
end
