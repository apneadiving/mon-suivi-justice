FactoryBot.define do
  factory :slot do
    date { '01/01/2021' }
    starting_time { Time.new()}
    place
  end
end