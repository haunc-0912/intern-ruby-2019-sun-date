function initRangeSlider() {
  var ageSlider = document.getElementById('age_slider');
  var startAge = $('#user_dating_information_attributes_start_age');
  var endAge = $('#user_dating_information_attributes_end_age');

  if(ageSlider) {
    let v1 = startAge.val();
    let v2 = endAge.val();

    if (!v1 || !v2) {
      v1 = 20;
      v2 = 50;
    }

    noUiSlider.create(ageSlider, {
      start: [v1, v2],
      tooltips: true,
      format: wNumb({
        decimals: 0
      }),
      range: {
        'min': 18,
        'max': 100
      }
    });

    ageSlider.noUiSlider.on('update', function (values, handle) {
      let valueList = ageSlider.noUiSlider.get();
      startAge.val(valueList[0]);
      endAge.val(valueList[1]);
    });
  }
}

$(document).on('turbolinks:load', initRangeSlider);
