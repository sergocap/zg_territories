@init_schedules = ->
  $('.js-schedules_fields.init_schedule .days .checkbox').each ->
    $(this).find('input.boolean').not('.js-ignore_init').attr('checked', 'checked')

  $('.js-schedules_fields .days .checkbox').each ->
    if $(this).find('input.boolean').prop('checked')
      $(this).addClass 'active'

  $(document).on 'change', '.js-schedules_fields .days .checkbox input.boolean', ->
    classes = '.' + $(this).closest('.form-group.boolean').attr('class').split(' ').join('.')
    similars = $(classes)

    if $(this).prop('checked')
      similars.find('.checkbox').removeClass('active')
      similars.find('.checkbox input.boolean').prop('checked', false)
      $(this).prop('checked', true)

    parent = $(this).closest('.checkbox')
    $(parent).toggleClass('active')

  $(document).on 'DOMNodeInserted', '.fields', ->
    if $(this).find('.fields').length == 0
      new_days = $(this).find('.days').children()
      new_days.each (id, new_day) ->
        classes = '.' + $(new_day).attr('class').split(' ').join('.')
        similars = $(classes)
        flag = false
        similars.each (id, similar) ->
          if $(similar).find('input.boolean').prop('checked')
            flag = true

        wrap = $(new_day).find('.checkbox')
        input = $(new_day).find('input.boolean')
        if flag
          wrap.removeClass('active')
          input.prop('checked', false)
        else
          wrap.addClass('active')
          input.prop('checked', true)

