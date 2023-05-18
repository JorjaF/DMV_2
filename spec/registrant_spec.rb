require './lib/registrant'

  RSpec.describe Registrant do
    
    it "exsits and has attributes" do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )

      expect(registrant_1.name).to eq('Bruce')
      expect(registrant_1.age).to eq(18)
      expect(registrant_1.permit?).to eq(true)

      expect(registrant_2.name).to eq('Penny')
      expect(registrant_2.age).to eq(15)
      expect(registrant_2.permit?).to eq(false)
    end

    it "can earn a permit" do
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )
      registrant_2.earn_permit

      expect(registrant_2.permit?).to eq(true)
    end
  end
