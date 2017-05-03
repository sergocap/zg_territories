@init_areas_map = ->
  ymaps.ready ->
    map = $('#map').draw_map()

  $.fn.draw_map = () ->
    $map = $(this)
    latitude = $('.common_storage').data('latitude')
    longitude = $('.common_storage').data('longitude')
    storages = $('.organization_storage')
    area_coordinates = []
    area_infos = []

    for storage, index in storages
      area_coordinates[index] = $(storage).data('area-coordinates')

    for storage, index in storages
      area_infos[index] = $(storage).data('infos')

    map = new ymaps.Map $map[0],
      center: [latitude, longitude]
      zoom: 12
      behaviors: ['drag', 'scrollZoom'],
      maxZoom: 23
      minZoom: 12

    map.controls.add 'zoomControl',
      left: 5
      top: 5

    map.controls.add('typeSelector');

    for area, index in area_coordinates
      myGeoObject = new (ymaps.GeoObject)({
        geometry:
          type: 'Polygon'
          coordinates: [area,[]]
          fillRule: 'nonZero'
        properties:
          balloonContent: area_infos[index]
        },
        fillColor: '#4611a7'
        strokeColor: '#FFF'
        opacity: 0.8
        strokeWidth: 1
        strokeStyle: 'solid')

      map.geoObjects.add(myGeoObject)

    map
