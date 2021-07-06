require 'rails_helper'

RSpec.describe Slot, type: :model do
  it { should belong_to(:place) }
  it { should belong_to(:appointment_type) }

  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:starting_time) }
  it { should validate_presence_of(:capacity) }
  it { should validate_presence_of(:duration) }

  describe '.relevant_and_available' do
    it 'returns available slots for a place and an appointment_type' do
      place1 = create(:place)
      place2 = create(:place)

      apt_type1 = create(:appointment_type)
      apt_type2 = create(:appointment_type)

      slot1 = create(:slot, place: place1,
                            appointment_type: apt_type1,
                            available: true)

      slot2 = create(:slot, place: place1,
                            appointment_type: apt_type1,
                            available: false)

      slot3 = create(:slot, place: place2,
                            appointment_type: apt_type1,
                            available: true)

      slot4 = create(:slot, place: place1,
                            appointment_type: apt_type2,
                            available: true)

      expect(Slot.relevant_and_available(place1, apt_type1)).to include(slot1)
      expect(Slot.relevant_and_available(place1, apt_type1)).not_to include(slot2)
      expect(Slot.relevant_and_available(place1, apt_type1)).not_to include(slot3)
      expect(Slot.relevant_and_available(place1, apt_type1)).not_to include(slot4)
    end
  end

  describe 'capacity' do
    it 'allows multiple appointments for a slot' do
      slot = create(:slot, available: true, capacity: 3, used_capacity: 0)

      create(:appointment, slot: slot).book

      slot.reload
      expect(slot.used_capacity).to eq(1)
      expect(slot.available).to eq(true)

      create(:appointment, slot: slot).book
      create(:appointment, slot: slot).book

      slot.reload
      expect(slot.used_capacity).to eq(3)
      expect(slot.available).to eq(false)
    end
  end
end
