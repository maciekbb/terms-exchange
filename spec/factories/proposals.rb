FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "example#{n}@nobody.com" }
  	password "secret123"
  end

  factory :subject do
  	name "TK"
  end

  factory :day do
  	name "monday"
  end

  factory :term do
  	hour "16:30"
  	day 
  	subject
  end

  factory :proposal do
    term
    user
    reason "Nie pasuje mi."
  end
end