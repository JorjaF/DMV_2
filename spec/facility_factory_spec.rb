require 'spec_helper'
require './lib/vehicle'
require './lib/vehicle_factory'
require './lib/dmv_data_service'
require './lib/facility_factory'

RSpec.describe FacilityFactory do

  let(:oregon) do 
    {:title=>"Albany DMV Office", :zip_code=>"97321", :website=>"http://www.oregon.gov/ODOT/DMV/pages/offices/albany.aspx", :type=>"DMV Location", :phone_number=>"541-967-2014", :agency=>"Transportation, Department of ", :location_1=>{:latitude=>"44.632897", :longitude=>"-123.077928", :human_address=>"{\"address\": \"2242 Santiam Hwy SE\", \"city\": \"Albany\", \"state\": \"OR\", \"zip\": \"97321\"}"}}
  end
  
  let(:new_york) do 
    {:office_name=>"SELDEN", :office_type=>"MOBILE OFFICE", :street_address_line_1=>"407 SELDEN RD", :city=>"SELDEN", :state=>"NY", :zip_code=>"11784", :monday_beginning_hours=>"8:00 AM", :monday_ending_hours=>"6:00 PM", :tuesday_beginning_hours=>"8:00 AM", :tuesday_ending_hours=>"6:00 PM", :wednesday_beginning_hours=>"8:00 AM", :wednesday_ending_hours=>"6:00 PM", :thursday_beginning_hours=>"8:00 AM", :thursday_ending_hours=>"6:00 PM", :friday_beginning_hours=>"8:00 AM", :friday_ending_hours=>"6:00 PM"}
  end

  let(:missouri) do 
    {:number=>"166", :dorregionnumber=>"8", :type=>"1MV", :name=>"OAKVILLE", :address1=>"3164 TELEGRAPH ROAD", :city=>"ST LOUIS", :state=>"MO", :zipcode=>"63125", :county=>"St. Louis County", :phone=>"(314) 887-1050", :fax=>"(314) 887-1051", :size=>"3", :email=>"OAKVILLEAGENTOFFICE@DOR.MO.GOV", :agent=>"York Management Group, LLC.", :officemanager=>"Rita Lahr", :daysopen=>"Monday-Friday - 9:00 to 5:00, Last Saturday  - 9:00 to 12:00", :holidaysclosed=>"Thanksgiving (11/24/22), Christmas Day Observed (12/26/22), New Year's Day Observed (01/02/23), Martin Luther King Day (01/16/23), President’s Day (02/20/23), Memorial Day (05/29/23), Juneteenth (06/19/2023), Independence Day (07/04/23), Labor Day (09/04/23), Veterans Day (11/10/23), Thanksgiving (11/23/23), Christmas Day Observed (12/25/23)", :additionaldaysclosed=>"7/2/22,     9/3/22,     11/25/22,     11/26/22,     11/28/2022 (at 11:45 AM),     12/22/2022 (at 1:30 PM ),     12/31/22,    1/25/2023 (at 9:00 AM until 11:00 AM ),    1/25/2023 (open at 11:00 AM ),   1/30/2023 (at 9:00 AM until 10:00 AM ),   1/30/2023 (open at 10:00 AM ),  2/22/2023 (at 3:00 PM ),     5/27/23,     9/2/23,     11/24/23,     11/25/23,     12/30/23", :latlng=>{:latitude=>"38.4981572", :longitude=>"-90.3001675"}, :facebook_url=>"https://m.facebook.com/people/Oakville-License-Office/100069096876261/", :textingphonenumber=>"(314) 730-0606", :othercontactinfo=>"Public Email: oakville@yorkmanagementgroup.com", :":@computed_region_ny2h_ckbz"=>"248", :":@computed_region_c8ar_jsdj"=>"51", :":@computed_region_ikxf_gfzr"=>"2210"}
  end

  it "exists" do
    facility_factory = FacilityFactory.new
    expect(facility_factory).to be_an_instance_of(FacilityFactory)
  end

  it "can make new oregon office" do 
    facility_factory = FacilityFactory.new
    facility = facility_factory.create_or_facility(oregon)
    expect(facility.name).to eq("Albany DMV Office")
    expect(facility.address).to eq("2242 Santiam Hwy SE, Albany, OR 97321")
    expect(facility.phone).to eq("541-967-2014")
  end

  it "can resolve an oregon address" do 
    raw_address = {:latitude=>"44.632897", :longitude=>"-123.077928",
      :human_address=>"{\"address\": \"2242 Santiam Hwy SE\", \"city\": \"Albany\", \"state\": \"OR\", \"zip\": \"97321\"}"}
    expect(FacilityFactory.new.parse_or_address(raw_address)).to eq("2242 Santiam Hwy SE, Albany, OR 97321")
  end

  it "can make a new NY office" do 
    facility_factory = FacilityFactory.new
    facility = facility_factory.create_ny_facility(new_york)
    expect(facility.name).to eq("SELDEN")
    expect(facility.address).to eq("407 SELDEN RD, SELDEN, NY 11784")
    expect(facility.phone).to eq(nil)
  end

  it "can resolve a NY address" do
    facility_factory = FacilityFactory.new
    address = facility_factory.parse_ny_address(new_york)
    expect(address).to eq("407 SELDEN RD, SELDEN, NY 11784")

  end
  it "can make a new MO office" do
    facility_factory = FacilityFactory.new
    facility = facility_factory.create_mo_facility(missouri)
    expect(facility.name).to eq("OAKVILLE")
    expect(facility.address).to eq("3164 TELEGRAPH ROAD, ST LOUIS, MO 63125")
    expect(facility.phone).to eq("(314) 887-1050")
  end

  it "can resolve a MO address" do 
    facility_factory = FacilityFactory.new
    address = facility_factory.parse_mo_address(missouri)
    expect(address).to eq("3164 TELEGRAPH ROAD, ST LOUIS, MO 63125")
  end
end
