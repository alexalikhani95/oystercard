class Oystercard
  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :history, :entry_station, :exit_station 

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    raise "Maximum balance is #{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Balance is less than #{MIN_FARE}" if balance < MIN_FARE
    @exit_station = nil
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
    add_journey
    @entry_station = nil
    deduct(MIN_FARE)
  end

  def in_journey?
    entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_journey
    @history << {
      entry_station: entry_station,
      exit_station: exit_station
    }
  end

end
