FactoryBot.define do
  factory :slot do
    date { '01/01/2021' }
    starting_time { Time.new }
    available { true }
    duration { 60 }
    capacity { 3 }
    used_capacity { 0 }
    agenda
    appointment_type
  end
end
