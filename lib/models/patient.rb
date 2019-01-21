# patient object/instance can only control the patient itself
# it has no control over room object/instance

class Patient
  attr_reader :name, :cured
  attr_accessor :id

  def initialize(attributes = {})
    @name = attributes[:name]
    @cured = attributes[:cured] || false
  end

  def cure
    @cured = true
  end
end


