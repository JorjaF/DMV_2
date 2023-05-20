require 'spec_helper'
require './lib/facility'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('Albany DMV Office')
      expect(@facility.address).to eq('2242 Santiam Hwy SE Albany OR 97321')
      expect(@facility.phone).to eq('541-967-2014')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#has service?' do
    it 'stars with no register vehicle' do
      cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      @facility.add_service('vehicle registration')
      expect(cruz.registration_date).to eq(nil)
      expect(@facility.registered_vehicles).to eq([])
    end
  end

  describe '#collected fees' do
    it 'starts with no collected fees' do
      expect(@facility.collected_fees).to eq(0)
    end
  end

  describe '#register vehicle' do
    it 'can register a vehicle' do
      facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
      cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )

      @facility.add_service('vehicle registration')

      expect(cruz.registration_date).to eq(nil)
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)

      @facility.register_vehicle(cruz)
      
      expect(cruz.registration_date).to eq(Date.today)
      expect(@facility.registered_vehicles).to eq([cruz])
      expect(@facility.collected_fees).to eq(100)

      @facility.register_vehicle(camaro)

      expect(camaro.registration_date).to eq(Date.today)

      @facility.register_vehicle(bolt)

      expect(bolt.registration_date).to eq(Date.today)
      expect(@facility.registered_vehicles).to eq([cruz, camaro, bolt])
      expect(@facility.collected_fees).to eq(325)

      expect(facility_2.registered_vehicles).to eq([])
      expect(facility_2.services).to eq([])
      expect(facility_2.register_vehicle(bolt)).to eq(nil)
      expect(facility_2.collected_fees).to eq(0)

    end
  end

  describe 'add plate type' do
    it 'can add plate type' do
      cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
      bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )  
      @facility.add_service('vehicle registration')
      @facility.register_vehicle(cruz)
      @facility.plate_type(camaro)
      @facility.plate_type(bolt)

      expect(@facility.plate_type(cruz)).to eq(:regular)
      expect(@facility.plate_type(camaro)).to eq(:antique)
      expect(@facility.plate_type(bolt)).to eq(:ev)
   end
  end
end
