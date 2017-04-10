$ ->
  init_vue_organization() if $('#vue-form_organization').length
  init_vue_organization_managers() if $('#vue-organization_managers').length
  init_vue_service_packs() if $('#vue-service_packs').length
  init_image_upload() if $('.js-image_upload_wrapper').length
  init_hierarch_list_items() if $('.wrapper_hierarch_list_items').length
  init_range_buttons() if $('.js-range_buttons').length
  init_schedules() if $('.js-schedules_fields').length
  init_slider() if $('.js-slider').length
  init_show_phone() if $('.js-show_phone').length
  init_organization_map() if $('.js-map_wrapper').length
  init_index_map() if $('.js-index_map_container').length
  true
