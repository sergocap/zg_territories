@init_range_buttons = ->
  $('.js-range_buttons .checkbox').each ->
    if $(this).find('input').attr('checked') == 'checked'
      $(this).addClass 'active'

  $('.js-range_buttons .checkbox input').change ->
    parent = $(this).closest('.checkbox')
    $(parent).toggleClass('active')

