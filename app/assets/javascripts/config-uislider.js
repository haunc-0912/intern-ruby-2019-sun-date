$(document).on('turbolinks:load', function () {
  var ageSlider = document.getElementById('age_slider');
  var startAge = $('#start_age');
  var endAge = $('#end_age');

  noUiSlider.create(ageSlider, {
    start: [20, 50],
    tooltips: true,
    format: wNumb({
      decimals: 0
    }),
    range: {
      'min': 18,
      'max': 70
    }
  });

  ageSlider.noUiSlider.on('update', function (values, handle) {
    let valueList = ageSlider.noUiSlider.get();
    startAge.val(valueList[0]);
    endAge.val(valueList[1]);
  });
});
