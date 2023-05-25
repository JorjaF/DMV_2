require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
  end
  #add a space here
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
      #get rid of this space
    end
  end
  #you created a helper method called add_fee(vehicle)
  #so you will need to have a unit test for this

  describe 'add plate type' do
    it 'can add plate type' do
      cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
      bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )  
      @facility.add_service('vehicle registration')
      @facility.plate_type(cruz)
      @facility.plate_type(camaro)
      @facility.plate_type(bolt)

      expect(@facility.plate_type(cruz)).to eq(:regular)
      expect(@facility.plate_type(camaro)).to eq(:antique)
      expect(@facility.plate_type(bolt)).to eq(:ev)
   end
  end

  describe 'taking a written test' do
    it 'can get a take a written test' do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 16 )
      registrant_3 = Registrant.new('Tucker', 15 )
      facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })

      expect(registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      expect(registrant_1.permit?).to eq(true)
      expect(@facility.adminster_written_test(registrant_1)).to eq(false)
      expect(registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    
      @facility.add_service('written test')
      @facility.add_service('permit test')
      @facility.adminster_written_test(registrant_1)
      
      expect(@facility.adminster_written_test(registrant_1)).to eq(true)
      expect(registrant_1.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
      
      expect(registrant_2.age).to eq(16)
      expect(registrant_2.permit?).to eq(false)
      expect(@facility.adminster_written_test(registrant_2)).to eq(false)

      registrant_2.earn_permit
      expect(registrant_2.permit?).to eq(true)
      
      facility_2.adminster_written_test(registrant_2)
      
      expect(@facility.adminster_written_test(registrant_2)).to eq(true)
      expect(registrant_2.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
    
      expect(registrant_3.age).to eq(15)
      expect(registrant_3.permit?).to eq(false)
      expect(@facility.adminster_written_test(registrant_3)).to eq(false)

      registrant_3.earn_permit

      expect(registrant_3.permit?).to eq(true)
      # expect(@facility.administer_road_test(registrant_3)).to eq(false)
      # expect(registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end
  
  describe 'taking a road test' do
    it 'can take a road test' do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 16 )
      registrant_2.earn_permit
      registrant_3 = Registrant.new('Tucker', 15 )
      facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
      @facility.add_service('written test')
      @facility.add_service('permit test')
      
      expect(@facility.administer_road_test(registrant_3)).to eq(false)

      registrant_3.earn_permit

      expect(@facility.administer_road_test(registrant_3)).to eq(false)
      expect(registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})

      expect(@facility.administer_road_test(registrant_1)).to eq(false)

      @facility.add_service('road test')
      @facility.adminster_written_test(registrant_1)
      @facility.administer_road_test(registrant_1)
            
      expect(@facility.administer_road_test(registrant_1)).to eq(true)
      expect(registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>false})

      @facility.adminster_written_test(registrant_2)
      @facility.administer_road_test(registrant_2)

      expect(@facility.administer_road_test(registrant_2)).to eq(true)
      expect(registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
    end
  end  

  describe 'renewing a license' do
    it 'can renew a license' do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 16 )
      registrant_3 = Registrant.new('Tucker', 15 )
      expect(@facility.renew_license(registrant_1)).to eq(false)
      
      @facility.add_service('permit test')
      @facility.add_service('written test')
      @facility.add_service('road test')
      @facility.add_service('renew license')

      @facility.adminster_written_test(registrant_1)
      @facility.administer_road_test(registrant_1)
      @facility.renew_license(registrant_1)

      expect(@facility.renew_license(registrant_1)).to eq(true)
      expect(@facility.renew_license(registrant_3)).to eq(false)

      registrant_2.earn_permit
      @facility.adminster_written_test(registrant_2)
      @facility.administer_road_test(registrant_2)
      @facility.renew_license(registrant_2)

      expect(@facility.renew_license(registrant_2)).to eq(true)
      #get rid of this space
    end
  end
end 
# These tests look good. Just make sure to unit test any helper methods that you create as well. 
# Specifically talkingabout add_fee and plate_type.