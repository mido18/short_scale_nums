require 'spec_helper'
describe ShortScaleNums do
  it "1 Million" do
    expect(prettified_number(1000000)).to eq("1M")
  end

  it "2.5 Million" do
    expect(prettified_number(2500000.34)).to eq("2.5M")
  end

  it "532 Hundred" do
    expect(prettified_number(532)).to eq("532")
  end

  it "1.1 Billion" do
    expect(prettified_number(1123456789)).to eq("1.1B")
  end

  it "1000000000000000" do
    expect(prettified_number(1000000000000000)).to eq("1000000000000000")
  end

  it "truncation [1,5]" do
    expect(truncation([1,5])).to eq("1.5")
  end

  it "truncation [1,0]" do
    expect(truncation([1,0])).to eq("1")
  end

  it "abbr 1000000" do
    expect(abbr(1000000)).to eq("M")
  end

  it "abbr 1000000000" do
    expect(abbr(1000000000)).to eq("B")
  end

  it "abbr 1000000000000" do
    expect(abbr(1000000000000)).to eq("T")
  end

  it "abbr 1000000000000000 should raise exception" do
    expect {abbr(1000000000000000)}.to raise_error(QuadrillionOrBiggerError)
  end

end