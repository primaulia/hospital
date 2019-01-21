# patient repository is an instance that has the ability to handle
# multiple patients

require 'csv'
require_relative 'room_repository'
require_relative 'patient'
require 'pry-byebug'

class PatientRepository
  def initialize(csv_file, room_repository)
    @patients = [] #initialize @patients to empty array
    @next_id = 1
    @csv_file = csv_file
    load_csv(@csv_file) # load the csv once and ignore
  end

  def add(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient
    save_csv # only save based on the current @patients array
  end

  private

  def save_csv
    csv_options = {
      force_quotes: true
    }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      # convert each patient object in @patients into row of ['id', 'name', 'cured']
      csv << ["id", "name", "cured"]
      @patients.each do |patient|
        csv << [patient.id.to_s, patient.name, patient.cured.to_s]
      end
    end
  end

  def load_csv(filepath)
    # # Getting @patients from CSV
    csv_options = {
      headers: true,
      header_converters: :symbol
    }

    CSV.foreach(filepath, csv_options) do |row|
      # create the patient obj
      patient_obj = Patient.new({
        name: row[:name],
        cured: row[:cured] == "true"
      })

      patient_obj.id = row[:id].to_i
      @patients << patient_obj
    end

    @next_id = @patients.empty? ? @next_id : @patients.last.id + 1
  end
end

room_repo = RoomRepository.new('rooms.csv') #init the room repository

# init the patient repository
patient_repo = PatientRepository.new('patients.csv', room_repo)

# create new patient
p1 = Patient.new({
  name: 'Sonia'
})

patient_repo.add(p1)

p2 = Patient.new({
  name: 'Cassy'
})

patient_repo.add(p2)















