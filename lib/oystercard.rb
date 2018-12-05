class Oystercard
  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :history

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @history = []
  end

  def top_up(amount)
    raise "Maximum balance is #{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Balance is less than #{MIN_FARE}" if balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @entry_station = nil
    @exit_station = station
  end

  def in_journey?
    entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
