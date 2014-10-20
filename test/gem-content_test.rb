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

  let(:gems_one_expected) do
    gems_one.select{|s| s.metadata && s.metadata["some-templates"] }
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
    subject.expects(:all_gems).returns(gems_one)
    subject.send(:all_gems_matching).sort.must_equal(gems_one_expected.sort)
  end

  it "finds latest gems" do
    subject.expects(:all_gems_matching).returns(gems_one_expected)
    subject.send(:active_or_latest_gems_matching).must_equal([gems_one_expected.sort.last])
  end

  it "finds latest gem from list" do
    subject.send(:active_or_latest_gem, ["fake-gem-name-one", gems_one_expected]).must_equal(gems_one_expected.sort.last)
  end

  it "finds active gems" do
    subject.expects(:all_gems_matching).returns(gems_two)
    subject.send(:active_or_latest_gems_matching).must_equal([gems_two.sort.first])
  end

  it "finds active gem on list" do
    subject.send(:active_or_latest_gem, ["fake-gem-name-two", gems_two]).must_equal(gems_two.sort.first)
  end

  it "returns gems paths" do
    subject.expects(:active_or_latest_gems_matching).returns(gems_one_expected.sort)
    subject.get_gem_paths.must_equal(
      [
        File.expand_path("../gems/gems/fake-gem-name-one-1.0.0/templates-v1", __FILE__),
        File.expand_path("../gems/gems/fake-gem-name-one-2.0.0/templates-v2", __FILE__),
      ]
    )
  end

  it "returns gems paths - no mocking - the real test" do
    subject.get_gem_paths.must_equal(
      [
        File.expand_path("../gems/gems/fake-gem-name-one-2.0.0/templates-v2", __FILE__),
        File.expand_path("../gems/gems/fake-gem-name-two-1.0.0/templates-v1", __FILE__),
      ]
    )
  end

end
