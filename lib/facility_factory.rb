class FacilityFactory

  def create_or_facility(facility)
    facility = facility.slice(:title,:location_1, :phone_number)
    facility[:name] = facility.delete(:title)
    facility[:address] = parse_or_address(facility.delete(:location_1))
    facility[:phone] = facility.delete(:phone_number)
    Facility.new(facility)
  end

  def parse_or_address(raw_address)
    raw = raw_address[:human_address]
    parsed_address = JSON.parse(raw)
    "#{parsed_address["address"]}, #{parsed_address["city"]}, #{parsed_address["state"]} #{parsed_address["zip"]}"
  end

  def create_ny_facility(facility)
    facility = facility.slice(:office_name,:street_address_line_1, :city, :state, :zip_code, :public_phone_number)
    facility[:name] =facility.delete(:office_name)
    facility[:address] = parse_ny_address(facility)
    facility[:phone] = facility.delete(:public_phone_number)
    facility = facility.slice(:name, :address, :phone)
    Facility.new(facility)
  end

  def parse_ny_address(raw_address)
    "#{raw_address[:street_address_line_1]}, #{raw_address[:city]}, #{raw_address[:state]} #{raw_address[:zip_code]}"
  end

  def create_mo_facility(facility)
    facility[:address] = parse_mo_address(facility)
    facility = facility.slice(:name, :address, :phone)
    Facility.new(facility)
  end

  def parse_mo_address(raw_address)
    "#{raw_address[:address1]}, #{raw_address[:city]}, #{raw_address[:state]} #{raw_address[:zipcode]}"
  end
end
