FactoryBot.define do
  factory :game do
    association :suggestor, factory: :user
    association :event
  end

end
