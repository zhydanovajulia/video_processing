FactoryBot.define do
  factory :video do
    user
    start_time { 3 }
    end_time { 10 }
    duration { 7 }
    file_processing { 0 }
  end
end
