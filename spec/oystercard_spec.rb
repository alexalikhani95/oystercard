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

    describe '#touch_in' do
      it 'changes in_journey to true' do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end

    context 'has already touched in' do
      before { subject.touch_in }

      describe '#touch_out' do
        it 'changes in_journey to false' do
          subject.touch_out
          expect(subject).not_to be_in_journey
        end

        it 'deducts minimum fare from balance' do
          expect{ subject.touch_out }.to change{ subject.balance }.by -Oystercard::MIN_FARE
        end
      end
    end
  end

  describe '#touch_in' do
    it 'raises an error if the balance is too low' do
      message = "Balance is less than #{Oystercard::MIN_FARE}"
      expect { subject.touch_in }.to raise_error message
    end
  end
end
