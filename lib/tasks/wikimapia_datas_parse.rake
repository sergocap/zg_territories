require 'csv'
namespace :wikimapia do
  desc 'Загрузка данных в модели из таблиц викимапии'
  task datas_import: :environment do
    prop_names = {
      wiki_id: 'Wikimapia ID',
      wiki_link: 'Ссылка (Википедия)',
      distance_to_city: 'Расстояние до города'
    }


    print "Введите путь до таблицы. В таблице должны присутствовать слудующие поля:
    id_wikimapia(0), Название(1), Описание(2), wiki_link(3), _(4), coordinates(5), расстояние до города(6), lat(7), lon(8) \n-> "
    file_name = STDIN.gets.strip
    file_path = Rails.root.join('lib/tasks', file_name)
    raise 'Файл не найден' unless File.exists?(file_path)
    puts 'Файл найден'

    print "\nВведите ID целевой категории на сайте \n-> "
    category_id = STDIN.gets.strip.to_i
    raise 'Категория не найдена' unless category = Category.where(:id => category_id).first
    puts "Категория \"#{category.title}\" найдена"

    wikimapia_id_prop = category.properties.where(title: prop_names[:wiki_id]).first
    raise "Не найдены свойство \"#{prop_names[:wiki_id]}\" у категории: " if wikimapia_id_prop.nil?
    wiki_link_prop = category.properties.where(title: prop_names[:wiki_link]).first
    raise "Не найдены свойство \"#{prop_names[:wiki_link]}\" у категории: " if wiki_link_prop.nil?
    distance_to_city_prop = category.properties.where(title: prop_names[:distance_to_city]).first
    raise "Не найдены свойство \"#{prop_names[:distance_to_city]}\" у категории: " if distance_to_city_prop.nil?
    puts "Свойства найдены"

    print "\nВведите ID пользователя которому будут присовены данные\n-> "
    user_id = STDIN.gets.strip
    raise 'Пользователь не найден' unless user = User.find_by(id: user_id)

    city_id = 11 #Томск

    CSV.foreach(file_path) do |row|
      if row[1].present?
        organization = Organization.create!(title: row[1],
                                           city_id: city_id,
                                           category_id: category.id,
                                           description: row[2],
                                           user_id: user.id,
                                           state: 'published')
        address = organization.build_address(city_id: city_id, longitude: row[8].to_f, latitude: row[7].to_f, area_coordinates: row[5])
        address.save
        organization.values.create(property_id: wikimapia_id_prop.id, integer_value: row[0].to_i)
        organization.values.create(property_id: wiki_link_prop.id, string_value: row[3])
        organization.values.create(property_id: distance_to_city_prop.id, integer_value: row[6].to_i)
        puts organization.title
      end
    end

  end
end
