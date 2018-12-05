require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'is not in a journey by default' do
    expect(subject).not_to be_in_journey
  end

  it 'has an empty history by default' do
    expect(subject.history).to be_empty
  end

  describe '#touch_in' do
    it 'raises an error if the balance is too low' do
      message = "Balance is less than #{Oystercard::MIN_FARE}"
      expect { subject.touch_in(entry_station) }.to raise_error message
    end
  end

  describe '#top_up' do
    it 'increases the balance of the card by a specified amount' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
    end
  end

  context 'has a maximum balance' do
    before { subject.top_up(Oystercard::MAX_BALANCE) }

    it 'raises an error if the maximum balance is exceeded' do
      message = "Maximum balance is #{Oystercard::MAX_BALANCE}"
      expect { subject.top_up(1) }.to raise_error message
    end

    context 'has touched in' do
      before { subject.touch_in(entry_station) }

      describe '#touch_in' do
        it 'remembers the entry station' do
          expect(subject.entry_station).to eq entry_station
        end
      end

      describe '#touch_out' do
        it 'deducts minimum fare from balance' do
          expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -Oystercard::MIN_FARE
        end

        context 'has touched out' do
          before { subject.touch_out(exit_station) }

          it 'remembers the exit station' do
            expect(subject.exit_station).to eq exit_station
          end

          it 'changes in_journey to false' do
            expect(subject).not_to be_in_journey
          end

          it 'creates one journey' do
            expect(subject.history).to include journey
          end

          it 'forgets the entry station' do
            expect(subject.entry_station).to be_falsey
          end
        end
      end
    end
  end
end
