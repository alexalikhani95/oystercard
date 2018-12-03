require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'tops up the card with money' do
    expect(subject.top_up(11)).to eq 11 
  end
end
