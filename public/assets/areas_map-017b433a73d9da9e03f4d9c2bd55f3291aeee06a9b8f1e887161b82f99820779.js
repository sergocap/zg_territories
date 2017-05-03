(function() {
  this.init_areas_map = function() {
    ymaps.ready(function() {
      var map;
      return map = $('#map').draw_map();
    });
    return $.fn.draw_map = function() {
      var $map, area, area_coordinates, area_infos, i, index, j, k, latitude, len, len1, len2, longitude, map, myGeoObject, storage, storages;
      $map = $(this);
      latitude = $('.common_storage').data('latitude');
      longitude = $('.common_storage').data('longitude');
      storages = $('.organization_storage');
      area_coordinates = [];
      area_infos = [];
      for (index = i = 0, len = storages.length; i < len; index = ++i) {
        storage = storages[index];
        area_coordinates[index] = $(storage).data('area-coordinates');
      }
      for (index = j = 0, len1 = storages.length; j < len1; index = ++j) {
        storage = storages[index];
        area_infos[index] = $(storage).data('infos');
      }
      map = new ymaps.Map($map[0], {
        center: [latitude, longitude],
        zoom: 12,
        behaviors: ['drag', 'scrollZoom'],
        maxZoom: 23,
        minZoom: 12
      });
      map.controls.add('zoomControl', {
        left: 5,
        top: 5
      });
      map.controls.add('typeSelector');
      for (index = k = 0, len2 = area_coordinates.length; k < len2; index = ++k) {
        area = area_coordinates[index];
        myGeoObject = new ymaps.GeoObject({
          geometry: {
            type: 'Polygon',
            coordinates: [area, []],
            fillRule: 'nonZero'
          },
          properties: {
            balloonContent: area_infos[index]
          }
        }, {
          fillColor: '#4611a7',
          strokeColor: '#FFF',
          opacity: 0.8,
          strokeWidth: 1,
          strokeStyle: 'solid'
        });
        map.geoObjects.add(myGeoObject);
      }
      return map;
    };
  };

}).call(this);
