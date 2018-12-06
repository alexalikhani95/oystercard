require "journey.rb"

describe Journey do
  it "returns entry station" do
    expect(subject.start("Aldgate")).to eq "Aldgate"
  end
  it "returns exit station" do
    expect(subject.exit("Aldgate")).to eq "Aldgate"
  end
  it "shows default journey status" do
    expect(subject.in_journey?).to eq false
  end
  it "shows journey status after touch in" do
    subject.start("Aldgate")
    expect(subject.in_journey?).to eq true
  end

  it "Adds a journey to history" do
    subject.start("Aldgate")
    subject.exit("Waterloo")
    subject.add_journey
    expect(subject.history).to eq [{:entry_station=>"Aldgate", :exit_station=>"Waterloo"}]
  end
  it "return either minimum fare" do
    subject.start("Aldgate")
    subject.exit("Waterloo")
    expect(subject.fare).to eq 1
  end
  it "return either penalty fare" do
    subject.start("Aldgate")
    subject.exit(nil)
    expect(subject.fare).to eq 6
  end

end
