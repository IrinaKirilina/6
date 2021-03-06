require "./instance_counter"
# Станция
# 1. Имеет название, которое указывается при ее создании
# 2. Может принимать поезда (по одному за раз)
# 3. Может возвращать список всех поездов на станции
# 4. Может возвращать список поездов на станции по типу грузовые, пассажирские
# 5. Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station
  # Mодуль InstanceCounter, содержащий методы: 1- увеличивающий счетчик кол-ва экземпляров класса и который можно вызвать из конструктора 2- возвращающий кол-во экземпляров данного класса
  include InstanceCounter

  # 1. Имеет название
  attr_reader :name
  # 3. Может возвращать список всех поездов на станции
  attr_reader :trains
  
  @@all = []

  # 1. Имеет название, которое указывается при ее создании
  # 2. Может принимать поезда
  def initialize(name)
    @name = name
    @trains = []
    @@all << self
    register_instance
  end

  # 2. Может принимать поезда (по одному за раз)
  def arrival(train)
    # в массив "поезда" добавляем "поезд", который нам передали в методе
    @trains << train
  end

  # 5. Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def departure(train)
    @trains.delete(train)
  end

  # 4. Может возвращать список поездов на станции по типу грузовые, пассажирские
  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  # Метод класса, который возвращает все станции (объекты), созданные на данный момент
  def self.all
    @@all
  end
end