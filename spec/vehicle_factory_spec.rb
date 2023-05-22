require 'spec_helper'
require './lib/vehicle'
require './lib/vehicle_factory'
require './lib/dmv_data_service'

RSpec.describe VehicleFactory do

  let(:washington) do 
    {:electric_vehicle_type=>"Battery Electric Vehicle (BEV)", :vin_1_10=>"WMEEJ9AA7E", :dol_vehicle_id=>"349158127", :model_year=>"2014", :make=>"SMART", :model=>"Fortwo Electric Drive", :vehicle_primary_use=>"Passenger", :electric_range=>"58", :odometer_reading=>"0", :odometer_code=>"Odometer reading is not collected at time of renewal", :new_or_used_vehicle=>"Used", :sale_price=>"0", :base_msrp=>"0", :transaction_type=>"Registration Renewal", :transaction_date=>"2021-06-07T00:00:00.000", :transaction_year=>"2021", :county=>"King", :city=>"SEATTLE", :state_of_residence=>"WA", :zip=>"98102", :non_clean_alternative_fuel=>"HB 2778 Eligiblity Requirements not met", :hb_2042_clean_alternative_fuel_vehicle_cafv_eligibility=>"HB 2042 Eligibility Requirements not met", :meets_2019_hb_2042_electric_range_requirement=>true, :meets_2019_hb_2042_sale_date_requirement=>false, :meets_2019_hb_2042_sale_price_value_requirement=>false, :_2019_hb_2042_battery_range_requirement=>"Meets battery range requirement", :_2019_hb_2042_purchase_date_requirement=>"Non-sale, registration transaction", :_2019_hb_2042_sale_price_value_requirement=>"Non-sale, registration transaction", :electric_vehicle_fee_paid=>"Yes", :transportation_electrification_fee_paid=>"Yes", :hybrid_vehicle_electrification_fee_paid=>"No", :census_tract_2020=>"53033007501", :legislative_district=>"43", :electric_utility=>"CITY OF SEATTLE - (WA)|CITY OF TACOMA - (WA)"}
  end
  
  it "exists" do
    vehicle_factory = VehicleFactory.new
    expect(vehicle_factory).to be_an_instance_of(VehicleFactory)
  end

  it "can create a WA vehicle" do
    vehicle_factory = VehicleFactory.new
    vehicle = vehicle_factory.create_wa_vehicle(washington)
    expect(vehicle.vin).to eq("WMEEJ9AA7E")
  end

  it "can create a any vehicle" do
    vehicle_factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations
    vehicles = vehicle_factory.create_vehicles(wa_ev_registrations)
    expect(vehicles.first).to be_an_instance_of(Vehicle)
  end
end
