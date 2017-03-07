@init_organization_map = () ->
  ymaps.ready ->
    city_field = $('#organization_address_attributes_city_id')
    street_field = $('#organization_address_attributes_street')
    house_field = $('#organization_address_attributes_house')
    latitude_field = $('#organization_address_attributes_latitude')
    longitude_field = $('#organization_address_attributes_longitude')
    city_val = city_field[0].options[city_field[0].selectedIndex].text

    map = $('#map').draw_organization_map()
    if longitude_field.val() == ''
      $(map).set_map_coordinates(city_val)

    $('#organization_address_attributes_house, #organization_address_attributes_street').keyup ->
      city_val = city_field[0].options[city_field[0].selectedIndex].text
      return false if street_field.val() == '' || house_field.val() == '' || city_val == ''
      $(map).set_map_coordinates([city_val, street_field.val(), house_field.val()].join(','))
    true

  $.fn.set_map_coordinates = (address) ->
    map = $(this)
    latitude_field = $('#organization_address_attributes_latitude')
    longitude_field = $('#organization_address_attributes_longitude')
    myGeocoder = ymaps.geocode(address)
    myGeocoder.then (res) ->
      coordinates_city = res.geoObjects.get(0).geometry.getCoordinates()
      latitude_field.val(coordinates_city[0])
      longitude_field.val(coordinates_city[1])
      #map.setCenter [latitude_field.val(), longitude_field.val()]
      map = $('#map').empty().draw_organization_map()
      map.geoObjects.each (geoObject) ->
        if (geoObject.properties.get('id') == 'placemark')
          geoObject.geometry.setCoordinates [latitude_field.val(), longitude_field.val()]

  $.fn.draw_organization_map = () ->
    $map = $(this)
    latitude_field = $('#organization_address_attributes_latitude')
    longitude_field = $('#organization_address_attributes_longitude')
    latitude = latitude_field.val() || $('.map_coords').attr('data-latitude')
    longitude = longitude_field.val() || $('.map_coords').attr('data-longitude')

    map = new ymaps.Map $map[0],
      center: [latitude, longitude]
      zoom: 16
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
    map.geoObjects.add(placemark)

    placemark.events.add 'dragend', (event) ->
      coordinates = placemark.geometry.getCoordinates()
      latitude_field.val (coordinates[0] + '').substring(0, 9)
      longitude_field.val (coordinates[1] + '').substring(0, 9)
      true

    map.events.add 'click', (event) ->
      coordinates = event.get('coordPosition')
      latitude_field.val (coordinates[0] + '').substring(0, 9)
      longitude_field.val (coordinates[1] + '').substring(0, 9)
      map.geoObjects.each (geoObject) ->
        if (geoObject.properties.get('id') == 'placemark')
          geoObject.geometry.setCoordinates [coordinates[0], coordinates[1]]
        true
      true

    map
