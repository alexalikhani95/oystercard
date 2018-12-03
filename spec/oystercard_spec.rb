require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'is not in a journey by default' do
    expect(subject).not_to be_in_journey
  end

  describe '#top_up' do
    it 'increases the balance of the card by a specified amount' do
      expect{ subject.top_up(11) }.to change{ subject.balance }.by 11
    end
  end

  context 'has a maximum balance' do
    before { subject.top_up(Oystercard::MAX_BALANCE) }

    it 'raises an error if the maximum balance is exceeded' do
      message = "Maximum balance is #{Oystercard::MAX_BALANCE}"
      expect { subject.top_up(1) }.to raise_error message
    end

    describe '#deduct' do
      it 'decreases the balance of the card by a specified amount' do
        expect{ subject.deduct(1) }.to change{ subject.balance }.by -1
      end
    end
  end

  describe '#touch_in' do
    it 'changes in_journey to true' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    it "changes in_journey to false" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
