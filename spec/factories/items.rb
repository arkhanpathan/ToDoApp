# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    title { 'Attend standup' }
    description { 'Discuss on outstanding high priority tickets' }
    start_date_time { DateTime.current }
    end_date_time { DateTime.current + 1.hour }
    status { 'todo' }
  end
end
