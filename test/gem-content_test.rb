=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "test_helper"
require "context-filters/context"

describe GemContent do

  subject do
    GemContent.new("some-templates")
  end

  let(:gems_all) do
    Gem::Specification._all
  end

  let(:gems_one) do
    gems_all.select{|s| s.name == "fake-gem-name-one"}
  end

  let(:gems_two) do
    gems_all.select{|s| s.name == "fake-gem-name-two"}
  end

  before do
    gems_two.find{ |s| s.version == Gem::Version.new("1.0.0") }.activate
  end

  it "initializes content_name" do
    subject.content_name.must_equal("some-templates")
  end

  it "detects gems" do
    specifications = subject.send(:all_gems_matching, gems_one)
    specifications.size.must_equal(2)
    specifications.map(&:name).must_equal(["fake-gem-name-one", "fake-gem-name-one"])
  end

  it "finds latest gems" do
    specifications = subject.send(:active_or_latest_gems_matching, gems_one)
    specifications.size.must_equal(1)
    specifications.map(&:version).must_equal([Gem::Version.new("2.0.0")])
  end

  it "finds active gems" do
    specifications = subject.send(:active_or_latest_gems_matching, gems_two)
    specifications.size.must_equal(1)
    specifications.map(&:version).must_equal([Gem::Version.new("1.0.0")])
  end

end
