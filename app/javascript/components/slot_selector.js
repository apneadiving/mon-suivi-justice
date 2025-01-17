import Rails from '@rails/ujs';

document.addEventListener('turbolinks:load',function() {
  let placeSelect = document.getElementById('appointment-form-place-select');
  let agendaSelect = document.getElementById('appointment-form-agenda-select');
  let aptTypeSelect = document.getElementById('appointment_appointment_type_id');
  let loadSlotsLink = document.getElementById('load-slots-link');
  let loadSlotsButton = document.getElementById('load-slots-button');

  agendaSelect.addEventListener('change', (e) => {
    if (aptTypeSelect.value) {
      Rails.ajax({
        type: 'GET',
        url: '/select_slot?agenda_id=' + agendaSelect.value + '&apt_type_id=' + aptTypeSelect.value,
        success: function() { allowSubmitOnSlotSelection(); }
      });
    }
  });

  aptTypeSelect.addEventListener('change', (e) => {
    if (agendaSelect.value) {
      Rails.ajax({
        type: 'GET',
        url: '/select_slot?agenda_id=' + agendaSelect.value + '&apt_type_id=' + aptTypeSelect.value,
        success: function() { allowSubmitOnSlotSelection(); }
      });
    }
  });

  function allowSubmitOnSlotSelection () {
    let slotsFields = document.getElementsByName('appointment[slot_id]');

    if (slotsFields.length) {
      let submitButton = document.getElementById('submit-new-appointment');

      slotsFields.forEach(field => field.addEventListener('change', () => {
        submitButton.disabled = false;
      }));
    } else {
      setTimeout(allowSubmitOnSlotSelection, 200);
    }
  }

  allowSubmitOnSlotSelection();
});
