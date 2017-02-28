@init_slider = ->
  $('.js-slider').each (index, item) ->
    $(item).slider({
      min: $(item).data('min'),
      max: $(item).data('max'),
      value: $(item).data('value'),
      ticks: $(item).data('ticks'),
      ticks_labels: $(item).data('ticks-labels')
    })
