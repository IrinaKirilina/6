require "./instance_counter"
# Маршрут
# 1. Имеет начальную и конечную станцию,
# 1.1.  а также список промежуточных станций.
# 2. Начальная и конечная станции указываются при создании маршрута,
# 2.1. а промежуточные могут добавляться между ними.
# 3. Может добавлять промежуточную станцию в список
# 4. Может удалять промежуточную станцию из списка
# 5. Может выводить список всех станций по-порядку от начальной до конечной

class Route
  # Mодуль InstanceCounter, содержащий методы: 1- увеличивающий счетчик кол-ва экземпляров класса и который можно вызвать из конструктора 2- возвращающий кол-во экземпляров данного класса
  include InstanceCounter

  # 1. Имеет станции
  # 5. Может выводить список всех станций по-порядку от начальной до конечной
  attr_reader :stations, :name

  # 2. Начальная и конечная станции указываются при создании маршрута
  def initialize(name, first_station, last_station)
    @stations = [first_station, last_station]
    @name = name
    register_instance
  end

  # 3. Может добавлять промежуточную станцию в список
  # 2.1. промежуточные могут добавляться между ними.
  def add_station(station)
    stations.insert(-2, station)
  end

  # 4. Может удалять промежуточную станцию из списка
  def delete_station(station)
    stations.delete(station)
  end
end