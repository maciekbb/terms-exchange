FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "example#{n}@nobody.com" }
  	password "secret123"
  end

  factory :subject do
  	name "TK"
  end

  factory :day do
  	sequence(:name) { |n| "day #{n}" }
  end

  factory :term do
  	sequence(:hour) { |n| "#{n%13}:#{n%60}" }
  	day 
  	subject
  end

  factory :proposal do
    term
    user
    reason "Nie pasuje mi."
  end
end