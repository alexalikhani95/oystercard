require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'increases the balance of the card by a specified amount' do
      expect{ subject.top_up(11) }.to change{ subject.balance }.by 11
    end

    it 'raises an error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      message = "Maximum balance is #{max_balance}"
      subject.top_up(max_balance)

      expect { subject.top_up(1) }.to raise_error message
    end
  end

  describe '#deduct' do
    it 'decreases the balance of the card by a specified amount' do
      subject.top_up(11)
      expect{ subject.deduct(1) }.to change{ subject.balance }.by -1
    end
  end
end
