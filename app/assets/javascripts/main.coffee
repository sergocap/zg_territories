$ ->
  init_vue_organization() if $('#vue-form_organization').length
  init_hierarch_list_items() if $('.wrapper_hierarch_list_items').length
  init_range_buttons() if $('.js-range_buttons').length
  init_schedules() if $('.js-schedules_fields').length
  init_slider() if $('.js-slider').length
  init_show_phone() if $('.js-show_phone').length
  init_organization_map() if $('.js-map_wrapper').length
  true
