require 'faker'

FactoryGirl.define do
  factory :category do
    sequence(:title) { |n| "#{Faker::Book.genre} #{n}" }

    factory :category_with_jobs do
      transient do
        jobs_count 5
      end
      after(:create) do |category, evaluator|
        create_list(:job, evaluator.jobs_count, category: category)
      end
    end
  end

  factory :company do
    sequence(:name) { |n| "#{Faker::Company.name} #{n}" }

    factory :company_with_jobs do
      transient do
        jobs_count 3
      end
      after(:create) do |company, evaluator|
        create_list(:job, evaluator.jobs_count, company: company)
      end
    end
  end

  factory :job do
    sequence(:title) { |n| "Developer #{n}" }
    description Faker::Lorem.paragraph(2)
    sequence(:level_of_interest) { |n| "#{n}" }
    sequence(:city) { |n| "#{Faker::Address.city} #{n}" }
    category
    company
  end
end