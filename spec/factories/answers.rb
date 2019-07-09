
FactoryBot.define do
  factory :answer do
    reply "Reply text"
    active true
    rating 1
    by "Me"
    question { Question.first || association(:question, query: "With question") }
  end
end
