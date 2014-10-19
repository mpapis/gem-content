=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "rubygems"
require "minitest"

# fix lib in LOAD_PATH and load version for gems manipulation
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# register our own path with gems
Gem.path << File.expand_path("../gems", __FILE__)
Gem.refresh

if
  RUBY_VERSION == "2.0.0" && # check Gemfile
  $0 != "-e" # do not do that in guard
then
  require "coveralls"
  require "simplecov"

  SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter,
    ]
    command_name "Unit Tests"
    add_filter "/test/"
  end

  Coveralls.noisy = true unless ENV["CI"]
end

# Autoload all lib/**/*.rb files so simplecov does not misses anything
Dir[File.expand_path("../../lib/**/*.rb", __FILE__)].each{|f| require f }

require "minitest/autorun" unless $0=="-e" # skip in guard
require "minitest/unit"
require "mocha/setup"
