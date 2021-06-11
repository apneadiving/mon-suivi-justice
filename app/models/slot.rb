class Slot < ApplicationRecord
  belongs_to :place

  validates :date, :starting_time, presence: true
  validates_inclusion_of :available, in: [true, false]

  scope :available_for_place, ->(place) { where(place_id: place.id, available: true) }

  def form_label
    "#{date.to_s(:base_date_format)} - #{starting_time.to_s(:time)}"
  end
end
