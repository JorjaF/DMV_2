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
  #nice helper here, make sure that you unit test this
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
    #I think you could condense this to something like this
    # if @services.include?('Written Test') && registrant.age >= 16 && registrant.permit == true
    #   registrant.license_data[:written] = true
    # else
    #   false 
    # end
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
    #something like this
    # if @services.include?('Road Test') && registrant.age >= 16 && registrant.permit == true
    #   registrant.license_data[:license] = true
    # else
    #   false 
    # end
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
    #something like this
    # if @services.include?('Renew Test') && registrant.age >= 16 && registrant.permit == true
    #   registrant.license_data[:renewed] = true
    # else
    #   false 
    # end
    if services.include?('renew license') == false
      return false
    end
    if registrant.license_data[:license] == false
      return false
    end
    registrant.license_data[:renewed] = true
  end
end
# Think of ways that you could DRY up the methods above
# Could you make a helper method that takes care of some of the redundancy