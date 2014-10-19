=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "gem-content/version"

class GemContent

  attr_reader :content_name

  def initialize(content_name)
    @content_name = content_name
  end

  def get_gem_paths(specifications = active_or_latest_gems_matching)
    specifications.map do |specification|
      File.join(
        specification.full_gem_path,
        specification.metadata[content_name]
      )
    end
  end

private

  def active_or_latest_gems_matching(specifications = all_gems_matching)
    specifications.group_by(&:name).map do |name, specifications|
      specifications.find(&:activated) or
      specifications.sort_by(&:version).last
    end
  end

  def all_gems_matching(specifications = Gem::Specification._all)
    specifications.select do |specification|
      specification.metadata.is_a?(Hash) and
      specification.metadata[content_name]
    end
  end

end
