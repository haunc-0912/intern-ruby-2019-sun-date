function initSelect2() {
  var select_location = $('#user_dating_information_attributes_dating_location');

  if(select_location) {
    select_location.select2({
      width: '100%',
      theme: 'bootstrap',
      ajax: {
        url: '/dating_criterias/search_location',
        dataType: 'json',
        delay: 300,
        data: function(params) {
          return {search_content: params.term};
        },
        processResults: function(data) {
          return {results: data.results}
        },
        cache: true
      },
      placeholder: I18n.t('set_criteria.search_location'),
      minimumInputLength: 1,
      templateResult: formatResult,
      templateSelection: formatSelection,
    }).trigger('change');
  }

  function formatResult(location) {
    if (location.loading) {
      return location.text;
    }
    return $('<div>'+location.name+'</div>');
  }

  function formatSelection(location) {
    return  location.name || location.text;
  }
}

$(document).on('turbolinks:load', initSelect2);
