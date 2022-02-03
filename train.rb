require "./manufacturer"
require "./instance_counter"

# require "./train"
# train1 = Train.new(12345)
# Train.find(12345)
# => #<Train ...>
#
# Train.instances

class Train
  # Модуль позволяет указывать название компании-производителя и получать его 
  include Manufacturer
  # Mодуль InstanceCounter, содержащий методы: 1- увеличивающий счетчик кол-ва экземпляров класса и который можно вызвать из конструктора 2- возвращающий кол-во экземпляров данного класса
  include InstanceCounter
  
  # Может возвращать текущую скорость, текущую станцию
  
  attr_reader :number, :type, :cars, :speed, :route, :current_station_index

  @@trains = []

  # Имеет номер (произвольная строка), тип (грузовой, пассажирский), вагоны
  def initialize(number)
    @number = number
    @speed = 0
    @route = route
    @current_station_index = current_station_index
    @cars = []
    @@trains << self
    register_instance
  end

  #  Может набирать скорость

  def accelerate
    speed += 1
  end

  # Может тормозить (сбрасывать скорость до нуля)

  def deccelerate
    speed -= 1 unless train_stopped?
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию)/ Mетод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.

  def add_car(car)
    cars << car if train_stopped? && train.type == car.type
  end

  def remove_car
    cars.delete(car) if train_stopped? && cars.count.positive?
  end

  # Может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.

  def assign_route(route)
    @route = route
    @current_station_index = 1
  end

  #Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.

  def move_forward
    @current_station_index += 1 if route && !last_staion?
  end

  def move_backward
    @current_station_index -= 1 if route && !first_station?
  end

  def first_station?
    current_station_index == 1
  end

  def last_station?
    current_station_index == route.stations.count
  end

  def train_stopped?
    speed == 0
  end

  # Возвращать предыдущую станцию

  def previous_station
    route.stations[current_station_index - 2].name if !first_station?
  end

  # Возвращать текущую станцию

  def current_station
    route.stations[current_station_index - 1].name
  end

  # Возвращать следующую cтанцию на основе маршрута

  def next_station
    route.stations[current_station_index].name if !last_station?
  end

  # Mетод класса принимает номер поезда (указанный при его создании) и возвращает объект поезда по номеру или nil, если поезд с таким номером не найден.
  def self.find(number)
    @@trains.find { |train| train.number == number }
  end 
end