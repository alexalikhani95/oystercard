class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_accessor :history

  def initialize
    @entry_station = nil
    @exit_station = nil
    @history = []
  end
  def start(station)
    @entry_station = station
  end
  def exit(station)
    @exit_station = station
  end
  def in_journey?
    @entry_station != nil
  end
  def add_journey
    @history << {
      entry_station: @entry_station,
      exit_station: @exit_station
    }
  end
  def fare
    @entry_station.nil? || @exit_station.nil? ? PENALTY_FARE : MIN_FARE
  end
end
private

# def incomplete_journey of hisotry?
#   @history.each do |hash|
#     hash.each do |key, value|
#       value.nil? ? true : false
#     end
#   end
# end
