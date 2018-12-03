require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'increases the balance of the card' do
      expect(subject.top_up(11)).to eq 11
    end

    it 'raises an error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      message = "Maximum balance is #{max_balance}"
      subject.top_up(max_balance)

      expect { subject.top_up(1) }.to raise_error message
    end
  end
end
