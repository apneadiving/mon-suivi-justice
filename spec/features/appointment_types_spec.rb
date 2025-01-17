require 'rails_helper'

RSpec.feature 'AppointmentType', type: :feature do
  before do
    create_admin_user_and_login
  end

  describe 'index' do
    it 'lists all appointment_types' do
      create(:appointment_type, name: 'type 1')
      create(:appointment_type, name: 'type 2')

      visit appointment_types_path

      expect(page).to have_content('type 1')
      expect(page).to have_content('type 2')
    end
  end

  describe 'update' do
    before do
      @appointment_type = create(:appointment_type, name: '1er contact')
    end

    it 'works' do
      visit appointment_types_path

      within first('.appointment-types-item-container') { click_link 'Modifier' }

      fill_in 'Nom', with: '2e contact'
      click_button 'Enregistrer'

      @appointment_type.reload
      expect(@appointment_type.name).to eq('2e contact')
    end

    it 'allows to update notification types' do
      notif_type1 = create(:notification_type, appointment_type: @appointment_type,
                                               role: :summon,
                                               template: 'Yo')
      notif_type2 = create(:notification_type, appointment_type: @appointment_type,
                                               role: :reminder,
                                               template: 'Man')

      visit edit_appointment_type_path(@appointment_type)

      within first('.notification-type-container') do
        fill_in 'Template', with: 'Yolo'
      end

      within first('.reminder-container') do
        fill_in 'Template', with: 'Girl'
      end

      click_button 'Enregistrer'

      notif_type1.reload
      expect(notif_type1.template).to eq('Yolo')

      notif_type2.reload
      expect(notif_type2.template).to eq('Girl')
    end

    it 'allows to add slot types', js: true do
      visit edit_appointment_type_path(@appointment_type)

      within first('.slot-types-container') do
        click_button 'Ajouter créneau'

        select 'Mardi', from: 'Jour'
        select '14', from: 'Heure'
        fill_in 'Durée', with: '60'
        fill_in 'Capacité', with: '5'
      end

      expect { click_button('Enregistrer') }.to change { SlotType.count }.by(1)
    end
  end
end
