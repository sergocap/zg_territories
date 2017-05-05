@init_sortable_properties = ->
  $('.js-sortable-wrapper').sortable
    axis: 'y'
    items: '.js-sortable-item'
    handle: '.js-handle-sortable'

    sort: (e, ui) ->
      ui.item.addClass('active-item-shadow')
    stop: (e, ui) ->
      ui.item.removeClass('active-item-shadow')

    update: (e, ui) ->
      path = $('.js-sortable-wrapper').attr('data-path')
      item_id = ui.item.data('id')
      ui.item.effect('highlight', 1500)
      position = ui.item.index()
      console.log item_id
      $.ajax
        type: 'put'
        url: path
        dataType: 'json'
        data: {
          category_property_id: item_id
          row_order: position
        }
      return
    true
  true

@init_new_root_category = ->
  $('.js-new_root_category').on 'ajax:success', (evt, response) ->
    new_category_link = $(this)
    $(new_category_link).after response
    $(new_category_link).css 'display', 'none'

    simple_form = $(new_category_link).next()
    $('.js-cancel_form_root_category').click ->
      $(simple_form).remove()
      $(new_category_link).css 'display', 'inline-block'

    $(simple_form).on 'ajax:success', (evt, response) ->
      $('.tree_categories').html response
      $(simple_form).find('input[type=text]').val ''

@init_new_subcategory = ->
  $(document).on 'ajax:success', '.js-new_subcategory', (evt, response) ->
    new_category_link = $(this)
    $(new_category_link).after response
    simple_form = $(new_category_link).next()
    parent_id = $(new_category_link).data('parentId')
    parent = $("li[data-id=#{parent_id}] > div.js-toggable")
    cancel = $(simple_form).find('.js-cancel_form_subcategory')

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
    $(this).toggleClass('glyphicon-chevron-down glyphicon-chevron-up')
    $(this).nextAll('.js-toggable').toggle()

@init_category_title = ->
  $(document).on 'mouseover', '.js-category_item', ->
    $(this).children('.hiddable').css 'display', 'inline-block'
  $(document).on 'mouseout', '.js-category_item', ->
    $(this).children('.hiddable').css 'display', 'none'

@init_delete_category = ->
  $(document).on 'ajax:success', '.js-delete_category', (evt, response) ->
    $(this).closest('li').remove()

@init_edit_category = ->
  $(document).on 'ajax:success', '.js-edit_category', (evt, response) ->
    edit_link = $(this)
    title = $(edit_link).closest('li').children('.js-category_title')
    $(title).replaceWith response
    simple_form = $(edit_link).closest('li').children('.simple_form')
    $(simple_form).css 'display', 'inline-block'

    $(simple_form).find('.cancel_form').on 'ajax:success', ->
      $(simple_form).replaceWith title

    $(simple_form).on 'ajax:success', (evt, response)->
      console.log response
      $(this).closest('li').replaceWith response








