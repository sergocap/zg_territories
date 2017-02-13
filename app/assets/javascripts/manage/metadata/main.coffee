$ ->
  init_new_root_category() if $('.js-new_root_category')
  init_new_subcategory() if $('.js-new_subcategory')
  init_handle_hidden() if $('.js-handle_hidden')
  true
