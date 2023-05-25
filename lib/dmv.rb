class Dmv
  attr_reader :facilities,
              :registered_vehicles

  def initialize
    @facilities = []
    @registered_vehicles = []
  end

  def add_facility(facility)
    @facilities << facility
  end

  def facilities_offering_service(service)
    @facilities.find_all do |facility| #nice job changing this to a find_all
      facility.services.include?(service)
    end
  end
end
