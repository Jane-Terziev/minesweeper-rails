FactoryBot.define do
  factory :board do
    id { SecureRandom.uuid }
    sequence(:name) { |n| "name_#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    width { 2 }
    height { 2 }
    bombs { 2}
  end
end