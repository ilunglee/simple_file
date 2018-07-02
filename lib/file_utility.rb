# Require Dependencies
require 'csv'

# Require Extensions
require 'extensions/array'

# Require Shared Features
require 'file_utility/stream/file'

# Require Features
require 'file_utility/csv'

# Base
module FileUtility

  @log_level = nil
  @logger    = nil
  @encoding  = 'UTF-8'

  class << self

    # Extend array class
    class ::Array; include FileUtility::Array; end

    attr_accessor :encoding

  end

  def self.setup
    yield self
  end

end
