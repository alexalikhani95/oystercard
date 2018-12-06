require "station.rb"

describe Station do
  station = Station.new(:name, :zone)

  it "takes station name" do
    expect(station.name).to eq :name
  end

  it "takes station zone number" do
    expect(station.zone).to eq :zone
  end
end
