class Address < ApplicationRecord
  belongs_to :organization

  def to_s
    return "here is address"
  end

  #тут такие замуты с отображением координат полигона -
  #изначально координаты были импортированы с wikimapia в виде строки [{'x':11.222, 'y':33.22}, {'x':1212.2323, 'y':2323} ....]
  #потом стало необходимо сохранять координаты забитые с фронта ymap`ом в виде строки [[33.22,11.22],[2323,1212.2323] ...]
  #(ymap`у нужен второй вариант)
  #моделька успешно кушает оба варианта с нижеприведённым методом
  #в методе pretty_area_coordinates идёт преобразование первого варианта [{}, {} ...] или просто вывод второго [[],[] ...]
  #!!!!напишу потом таску по преобразованию всех записей первого варианта (если не забуду (поленюсьo)).
  #p.s. при редактировании инста сохраняется нужный вариант вида координат, так что таска может не понадобится
  def pretty_area_coordinates
    return [] unless area_coordinates.present?
    json_decode = JSON.parse(area_coordinates)
    return json_decode if json_decode[0].kind_of?(Array)
    json_decode = JSON.parse(area_coordinates)
    json_decode.map {|ob| [ob['y'], ob['x']] }
  end
end
