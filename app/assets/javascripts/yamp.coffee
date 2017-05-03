@init_organization_map = () ->
  ymaps.ready ->
    if $('.map_show_mode').length == 0
      latitude_field = $('#organization_address_attributes_latitude')
      longitude_field = $('#organization_address_attributes_longitude')
      city_val = $('#organization_address_attributes_city_title').val()

      map = $('#map').draw_organization_map()
      if longitude_field.val() == ''
        $(map).set_map_coordinates(city_val)
    else
      map = $('#map').draw_organization_map()

  $.fn.set_map_coordinates = (address) ->
    map = $(this)
    latitude_field = $('#organization_address_attributes_latitude')
    longitude_field = $('#organization_address_attributes_longitude')
    myGeocoder = ymaps.geocode(address)
    myGeocoder.then (res) ->
      coordinates_city = res.geoObjects.get(0).geometry.getCoordinates()
      latitude_field.val(coordinates_city[0])
      longitude_field.val(coordinates_city[1])
      map = $('#map').empty().draw_organization_map()
      map.geoObjects.each (geoObject) ->
        if (geoObject.properties.get('id') == 'placemark')
          geoObject.geometry.setCoordinates [latitude_field.val(), longitude_field.val()]

  $.fn.draw_organization_map = () ->
    $map = $(this)
    storages = $('.organization_storage')
    area_coordinates = []
    for storage, index in storages
      area_coordinates[index] = $(storage).data('area-coordinates')

    latitude_field = $('#organization_address_attributes_latitude')
    longitude_field = $('#organization_address_attributes_longitude')
    latitude = latitude_field.val() || $('.map-coordinates').data('latitude')
    longitude = longitude_field.val() || $('.map-coordinates').data('longitude')

    map = new ymaps.Map $map[0],
      center: [latitude, longitude]
      zoom: 12
      behaviors: ['drag', 'scrollZoom'],
      maxZoom: 23
      minZoom: 12

    map.controls.add 'zoomControl',
      top: 5
      left: 5

    placemark = new ymaps.GeoObject
      geometry:
        type: 'Point'
        coordinates: [latitude, longitude]
      properties:
        id: 'placemark'
    ,
      draggable: true
      iconImageHref: '/assets/organization_placemark.png'
      iconImageOffset: [-15, -40]
      iconImageSize: [37, 42]

    map.controls.add('typeSelector');

    map.geoObjects.add(placemark)
    for p in area_coordinates[0]
      draw_areamark(map, p[0], p[1])

    placemark.events.add 'dragend', (event) ->
      coordinates = placemark.geometry.getCoordinates()
      latitude_field.val (coordinates[0] + '').substring(0, 9)
      longitude_field.val (coordinates[1] + '').substring(0, 9)
      true

    map.events.add 'click', (event) ->
      type_input = $('input[name=type_input_for_map]:checked')
      coordinates = event.get('coordPosition')
      lat = (coordinates[0] + '').substring(0, 9)
      lon = (coordinates[1] + '').substring(0, 9)
      if type_input.val() == 'placemark'
        latitude_field.val lat
        longitude_field.val lon
        map.geoObjects.each (geoObject) ->
          if (geoObject.properties.get('id') == 'placemark')
            geoObject.geometry.setCoordinates [coordinates[0], coordinates[1]]
          true
      else if (type_input.val() == 'areamark')
        draw_areamark(map, lat, lon)

    map

  draw_areamark = (map, lat, lon) ->
    areamark = new ymaps.GeoObject
      geometry:
        type: 'Point'
        coordinates: [lat, lon]
      properties:
        id: 'areamark'
    ,
      draggable: true
      iconImageHref: '/assets/areamark.png'
      iconImageOffset: [-15, -40]
      iconImageSize: [37, 42]

    areamark.events.add 'click', (event) ->
      map.geoObjects.remove areamark
      draw_area(map)
      true

    areamark.events.add 'dragend', (event) ->
      draw_area(map)
      true

    map.geoObjects.add(areamark)
    draw_area(map)
    true

  draw_area = (map) ->
    area_coordinates = []
    index = 0
    map.geoObjects.each (obj) ->
      if (obj.properties.get('id') == 'areamark')
        area_coordinates[index] = obj.geometry.getCoordinates()
        index += 1
      if (obj.properties.get('id') == 'polygon')
        map.geoObjects.remove obj

    $('input[name*=area_coordinates]').val(JSON.stringify(area_coordinates))

    myGeoObject = new (ymaps.GeoObject)({
      geometry:
        type: 'Polygon'
        coordinates: [area_coordinates,[]]
        fillRule: 'nonZero'
      properties:
        id: 'polygon'
      },
      fillColor: '#00FF00'
      strokeColor: '#0000FF'
      opacity: 0.7
      strokeWidth: 0.1
      strokeStyle: 'shortdash')

    map.geoObjects.add(myGeoObject)
    true


