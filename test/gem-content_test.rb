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

  it "initializes content_name" do
    subject.content_name.must_equal("some-templates")
  end

end
