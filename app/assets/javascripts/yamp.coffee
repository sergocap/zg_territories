@init_organization_map = () ->
  ymaps.ready ->
    if $('.map_show_mode').length == 0
      street_field = $('#organization_address_attributes_street')
      house_field = $('#organization_address_attributes_house')
      latitude_field = $('#organization_address_attributes_latitude')
      longitude_field = $('#organization_address_attributes_longitude')
      city_val = $('#organization_address_attributes_city_title').val()

      map = $('#map').draw_organization_map()
      if longitude_field.val() == ''
        $(map).set_map_coordinates(city_val)

      $('#organization_address_attributes_house, #organization_address_attributes_street').keyup ->
        return false if street_field.val() == '' || house_field.val() == '' || city_val == ''
        $(map).set_map_coordinates([city_val, street_field.val(), house_field.val()].join(','))
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
    latitude_field = $('#organization_address_attributes_latitude')
    longitude_field = $('#organization_address_attributes_longitude')
    latitude = latitude_field.val() || $('.map-coordinates').data('latitude')
    longitude = longitude_field.val() || $('.map-coordinates').data('longitude')

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

    if $('.map_show_mode').length == 0

      draw_polygon = () ->
        area_coordinates = []
        index = 0
        map.geoObjects.each (obj) ->
          if (obj.properties.get('id') == 'areamark')
            area_coordinates[index] = obj.geometry.getCoordinates()
            index += 1

          if (obj.properties.get('id') == 'polygon')
            map.geoObjects.remove obj

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
        else if type_input.val() == 'areamark'
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
            draw_polygon()
            true

          areamark.events.add 'dragend', (event) ->
            draw_polygon()
            true

          map.geoObjects.add(areamark)
          draw_polygon()

        true
    map
