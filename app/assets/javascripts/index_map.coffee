@init_index_map = ->
  ymaps.ready ->
    map = $('#map').draw_map()

  $.fn.draw_map = () ->
    $map = $(this)
    latitude = $('.city_storage').data('latitude')
    longitude = $('.city_storage').data('longitude')
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
      top: 5
      right: 5

    for area, index in area_coordinates
      geoObject = new ymaps.GeoObject
        geometry:
            type: 'Polygon'
      myGeoObject = new (ymaps.GeoObject)({
        geometry:
          type: 'Polygon'
          coordinates: [area,[]]
          fillRule: 'nonZero'
        properties:
          balloonContent: area_infos[index]
        },
        fillColor: '#00FF00'
        strokeColor: '#0000FF'
        opacity: 0.5
        strokeWidth: 1
        strokeStyle: 'shortdash')

      map.geoObjects.add(myGeoObject);

    map


