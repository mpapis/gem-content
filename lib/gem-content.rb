=begin
Copyright 2014 Michal Papis <mpapis@gmail.com>

See the file LICENSE for copying permission.
=end

require "gem-content/version"

# Find gems with defined content name in metadata and
# return pull path to the content
class GemContent

  # shortcut to initialize and get the paths in one line
  # @param content_name [String] the path marker to read from gems metadata
  # @return [Array<String>] all gems paths containing requested content
  def self.get_gem_paths(content_name)
    self.new(content_name).get_gem_paths
  end

  # @return [String] content name filter
  attr_reader :content_name

  # initializes the filtered content path
  # @param content_name [String] the path marker to read from gems metadata
  def initialize(content_name)
    @content_name = content_name
  end

  # @return [Array<String>] all gems paths containing requested content
  def get_gem_paths
    active_or_latest_gems_matching.map do |specification|
      File.join(
        specification.full_gem_path,
        specification.metadata[content_name]
      )
    end
  end

private

  # filter active / latest gem versions
  def active_or_latest_gems_matching
    all_gems_matching.group_by(&:name).map do |name, specifications|
      active_or_latest_gem(specifications)
    end
  end

  # find active or latest gem in given set
  def active_or_latest_gem(specifications)
    specifications.find(&:activated) or specifications.sort.last
  end

  # filter gems with content_name metadata
  def all_gems_matching
    all_gems.select do |specification|
      specification.metadata.is_a?(Hash) and
      specification.metadata[content_name]
    end
  end

  # get all gem specifications
  def all_gems
    Gem::Specification._all
  end

end
