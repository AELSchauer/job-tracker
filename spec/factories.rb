require 'faker'

FactoryGirl.define do
  # factory :comment_options do
  #   [
  #     Faker::Lorem.paragraphs(rand(2..3)).join("\r\n\r\n"),
  #     Faker::Lorem.sentences(3.join(" ")),
  #     Faker::Lorem.sentences(2.join(" ")),
  #     Faker::Lorem.sentences(1.join(" "))
  #   ]
  # end

  # factory :comment do
  #   content { generate(:comment_options).sample }
  #   job
  # end

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
    description Faker::Lorem.paragraphs(3).join("\r\n\r\n")
    sequence(:level_of_interest) { |n| "#{n}" }
    sequence(:city) { |n| "#{Faker::Address.city} #{n}" }
    category
    company
  end

  factory :contact do
    full_name "MyString"
    position "MyString"
    email "MyString"
    company nil
  end
end