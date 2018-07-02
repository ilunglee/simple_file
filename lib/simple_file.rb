# Require Dependencies
require 'csv'

# Require Extensions
require 'extensions/array'

# Require Shared Features
require 'simple_file/stream/file'

# Require Features
require 'simple_file/csv'

# Base
module SimpleFile

  @log_level = nil
  @logger    = nil
  @encoding  = 'UTF-8'

  class << self

    # Extend array class
    class ::Array; include SimpleFile::Array; end

    attr_accessor :encoding

  end

  def self.setup
    yield self
  end

end
