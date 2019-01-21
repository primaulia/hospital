# room object/instance will need patient object/instance
# to set the room variable of patient

require_relative 'patient'

class Room
  attr_reader :patients
  attr_accessor :id

  def initialize(attributes = {})
    @capacity = attributes[:capacity] || 5
    @patients = attributes[:patients] || []
  end

  def full?
    @patients.size == @capacity
  end

  def add_patient(patient)
    # fail Exception, "Room is full!" if full?
    patient.room = self
    @patients << patient
  end
end

p1 = Patient.new({
  name: 'Prima'
})

puts "before adding p1 to any room"
p p1.room

r1 = Room.new()
# p r1.full?
# puts
# p r1

r1.add_patient(p1)

puts
puts "after add_patient(p1) to r1"
p p1.room

puts
puts "r1 now has one patients"
p r1.patients










