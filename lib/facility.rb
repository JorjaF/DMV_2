class Facility
  attr_reader :name, 
              :address, 
              :phone, 
              :services,
              :registered_vehicles,
              :collected_fees,
              :plate_type

  def initialize(name:, address:, phone:, collected_fees: 0)
    @name = name
    @address = address
    @phone = phone
    @services = []
    @registered_vehicles = []
    @collected_fees = collected_fees
    @plate_type = nil
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
      return nil if services.include?('vehicle registration') == false
      vehicle.registration_date = Date.today
      @registered_vehicles << vehicle
      @collected_fees += add_fee(vehicle)
  end

  def add_fee(vehicle)
    if vehicle.antique?
      25
    elsif vehicle.electric_vehicle?
      200
    else
      100
    end
  end

  def plate_type(vehicle)
    if vehicle.antique?
      :antique
    elsif vehicle.electric_vehicle?
      :ev
    else
      :regular
    end
  end

  def adminster_written_test(registrant)
    if services.include?('written test') == false
      return false
    end
    if registrant.age < 16
      return false
    end
    if registrant.permit? == false
      return false
    end
    registrant.license_data[:written] = true
  end

  def administer_road_test(registrant)
    if services.include?('road test') == false
      return false
    end
    if registrant.age < 16
      return false
    end
    if registrant.license_data[:written] == false
      return false
    end
    registrant.license_data[:license] = true
  end

  def renew_license(registrant)
    if services.include?('renew license') == false
      return false
    end
    if registrant.license_data[:license] == false
      return false
    end
    registrant.license_data[:renewed] = true
  end
end
