class Registrant

  attr_reader :name, 
              :age,
              :permit,
              :license_data

  def initialize(name, age, permit = false)
    @name = name
    @age = age
    @permit = permit
    @license_data = {:written=>false, :license=>false, :renewed=>false}
    end

  def permit?
    @permit
  end

  def earn_permit
    @permit = true
    #this is great. One thing that you could do would be to add what is called a guard clause.
    #@permit = true if @age >= 15
  end
end
