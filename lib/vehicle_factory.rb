class VehicleFactory
  
  def create_wa_vehicle(vehicle)
    vehicle = vehicle.slice(:vin_1_10, :model, :make, :model_year).merge({engine: :ev})
    vehicle[:year] = vehicle.delete(:model_year)
    vehicle[:vin] = vehicle.delete(:vin_1_10)
    Vehicle.new(vehicle)
  end 


  def create_vehicles(vehicles)
    vehicles.map do |vehicle|
      create_wa_vehicle(vehicle)
    end
  end
end
# This is a great start. Could we create a single method called create_vehichles that takes an argument
# of whatever api data and then creates vehicle objects. The way you have this now, if we received data 
# from lets say ny_vehicle, you would have to create another method for that like your create_wa_vehicle. An example
# def create_vehicles(washington_vehicles)
#   washington_vehicles.map do |vehicle|
#     Vehicle.new({
#       engine: :ev,
#       make: vehicle[:make],
#       model: vehicle[:model],
#       vin: vehicle[:vin_1_10],
#       year: vehicle[:model_year]
#     })
#   end
# end