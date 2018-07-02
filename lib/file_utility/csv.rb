module FileUtility

  # CSV
  class CSV

    include FileUtility::Stream::File

    MalformedCSVError = Class.new StandardError
    NotFileTypeError  = Class.new StandardError

    attr_accessor :file, :col_sep, :encoding, :count, :errors, :results

    def initialize(file, *args)
      options   = args.extract_options!
      @results  = []
      @encoding = options.delete(:encoding) { 'iso-8859-1:utf-8' }
      @col_sep  = options.delete(:col_sep)  { ',' }
      @mapping  = options.delete(:mapping)  { {} }
      @file     = read_file(file)
    end

    def import
      begin
        file.each_with_index do |row, index|
          self.count = (index + 1)
          results.push Hash[*map_fields(row).flatten]
        end
      rescue StandardError => e
        self.errors = e
      end
      self
    end

    def mapping
      Hash[*headers.zip(headers).flatten].transform_keys!(&:to_s).
        merge(@mapping.transform_keys!(&:to_s))
    end

    def headers
      @headers ||= file.headers
    end

    private

    def map_fields(row)
      mapping.map do |key, value|
        [value.to_sym, encode_attr(row[key])]
      end
    end

    def read_file(file)
      raise NotFileTypeError unless file.is_a? File
      ::CSV.parse(file.read, col_sep: col_sep, headers: :first_row,
                             row_sep: :auto, quote_char: quote_chars.shift,
                             encoding: encoding)
    rescue ::CSV::MalformedCSVError
      quote_chars.empty? ? raise : retry
    end

    def quote_chars
      %w[" | ~ ^ & *]
    end

  end

end
