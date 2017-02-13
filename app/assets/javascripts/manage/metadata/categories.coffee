@init_new_root_category = ->
  $('.js-new_root_category').on 'ajax:success', (evt, response) ->
    $('.root_categories').append response
    $(this).css 'display', 'none'

    $('.js-cancel_new_root_category').click ->
      $('.simple_form.new_category').remove()
      $('.js-new_root_category').css 'display', 'inline-block'


