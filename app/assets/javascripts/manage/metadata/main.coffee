$ ->
  init_sortable_properties() if $('.js-sortable-wrapper').length
  if $('.tree_categories').length
    init_new_root_category()
    init_new_subcategory()
    init_handle_hidden()
    init_category_title()
    init_delete_category()
    init_edit_category()
  true
