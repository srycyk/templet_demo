
FactoryBot.define do
  factory :question do
    query "Query text"

    category { Category.first || association(:category, name: "With question") }
  end
end
