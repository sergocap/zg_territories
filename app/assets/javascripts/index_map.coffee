@init_index_map = ->
  ymaps.ready ->
    map = $('#map').draw_map()

  $.fn.draw_map = () ->
    $map = $(this)
    latitude = 56.49771
    longitude = 84.97437

    map = new ymaps.Map $map[0],
      center: [latitude, longitude]
      zoom: 16
      behaviors: ['drag', 'scrollZoom'],
      maxZoom: 23
      minZoom: 12

    map.controls.add 'zoomControl',
      top: 5
      right: 5

    map


