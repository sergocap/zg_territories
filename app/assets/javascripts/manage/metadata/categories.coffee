@init_new_root_category = ->
  $('.js-new_root_category').on 'ajax:success', (evt, response) ->
    new_category_link = $(this)
    $(new_category_link).after response
    $(new_category_link).css 'display', 'none'

    simple_form = $(new_category_link).next()
    $('.js-cancel_new_root_category').click ->
      $(simple_form).remove()
      $(new_category_link).css 'display', 'inline-block'

    $(simple_form).on 'ajax:success', (evt, response) ->
      $('.root_categories').html response
      $(simple_form).find('input[type=text]').val ''

@init_new_subcategory = ->
  $(document).on 'ajax:success', '.js-new_subcategory', (evt, response) ->
    new_category_link = $(this)
    $(new_category_link).after response
    simple_form = $(new_category_link).next()
    parent_id = $(new_category_link).data('parentId')
    parent = $("li[data-id=#{parent_id}] > div.js-toggable")
    cancel = $(simple_form).find('.js-cancel_new_subcategory')

    $(new_category_link).css 'display', 'none'

    $(cancel).click ->
      $(simple_form).remove()
      $(new_category_link).css 'display', 'inline-block'

    $(simple_form).on 'ajax:success', (evt, response) ->
      list = $(parent).find('ul.categories_children')[0]
      $(list).html response
      $(simple_form).find('input[type=text]').val ''

@init_handle_hidden = ->
  $(document).on 'click', '.js-handle_hidden', ->
    $(this).toggleClass('glyphicon-plus glyphicon-minus')
    $(this).next('.js-toggable').toggle()
