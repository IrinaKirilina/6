require "./manufacturer"
# Cоздан класс, который является родителем для классов CargoCar, CargoTrain
class Car
  # Модуль позволяет указывать название компании-производителя и получать его
  include Manufacturer

  # Имеет тип (грузовой/пассажирский)
  attr_accessor :type  
        
end