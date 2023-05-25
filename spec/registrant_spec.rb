require 'spec_helper'


  RSpec.describe Registrant do
    
    it "exsits and has attributes" do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )
      expect(registrant_1).to be_an_instance_of(Registrant)

      expect(registrant_1.name).to eq('Bruce')
      expect(registrant_1.age).to eq(18)
      expect(registrant_1.permit?).to eq(true)

      expect(registrant_2.name).to eq('Penny')
      expect(registrant_2.age).to eq(15)
      expect(registrant_2.permit?).to eq(false)
    end

    it "can know license data" do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )
      expect(registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      #get rid of this blank space
    end
    #add a space here
    it "can earn a permit" do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )
      
      expect(registrant_2.permit?).to eq(false)
      expect(registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    
      registrant_2.earn_permit

      expect(registrant_2.permit?).to eq(true)
    end
  end
  #these tests look good
  # added this to have a PR for grading purposes
