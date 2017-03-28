require 'singleton'

class MainCities
  attr_accessor :datas
  include Singleton

  def initialize
    update_datas
  end

  def update_datas
    @datas = JSON.parse RestClient.get(Settings['profile.api_main_cities'])
  end

  def all
    @datas.map {|data| Hashie::Mash.new(data) }
  end

  def find_by(key, value)
    res = @datas.find {|data| data[key.to_s] == value }
    Hashie::Mash.new(res)
  end
end
