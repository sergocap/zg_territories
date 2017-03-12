@init_show_phone = ->
  $('.js-show_phone').on 'click', ->
    link = $(this)
    $.ajax
      url: "/organizations/show_phone"
      type: "GET"
      data:
        organization_id: $(link).data('id')
      success: (response) ->
        $(link).parent().find('.js-phone').html(response)
        $(link).remove()
      false
    false
  return
