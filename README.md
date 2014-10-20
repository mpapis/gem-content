# GemContent

[![Gem Version](https://badge.fury.io/rb/gem-content.png)](http://rubygems.org/gems/gem-content)
[![Build Status](https://travis-ci.org/mpapis/gem-content.png?branch=master)](https://travis-ci.org/mpapis/gem-content)
[![Code Climate](https://codeclimate.com/github/mpapis/gem-content.png)](https://codeclimate.com/github/mpapis/gem-content)
[![Coverage Status](https://coveralls.io/repos/mpapis/gem-content/badge.png?branch=master)](https://coveralls.io/r/mpapis/gem-content?branch=master)
[![Dependency Status](https://gemnasium.com/mpapis/gem-content.png)](https://gemnasium.com/mpapis/gem-content)
[![Inline docs](http://inch-ci.org/github/mpapis/gem-content.png)](http://inch-ci.org/github/mpapis/gem-content)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/mpapis/gem-content/master/frames)
[![Github Code](http://img.shields.io/badge/github-code-blue.svg)](https://github.com/mpapis/gem-content)

Search gems for content directory

## Installation

with `rubygems`:

```bash
gem install gem-content
```

with `bundler`, add to `Gemfile`:

```ruby
gem "gem-content"
```

and run:

```bash
bundle install
```

## Defining gems

In the gems you want to be detected add in `*.gemspec` file:

```ruby
s.metadata = {
  "some-templates" => "templates-v1"
}
```

Where the `some-templates` is the search key and `templates-v1` is path
inside of the gem, do not forget to add this path to `s.files`.

## Finding gem paths

```ruby
require "gem-content"

GemContent.get_gem_paths("some-templates")
# => ["/path/to/gems/gem-name-version/templates-v1"]
```
