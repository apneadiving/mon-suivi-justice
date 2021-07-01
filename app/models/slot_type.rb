class SlotType < ApplicationRecord
  belongs_to :appointment_type
  validates :week_day, :duration, :starting_time, :capacity, presence: true

  enum week_day: %i[monday tuesday wednesday thursday friday]
end