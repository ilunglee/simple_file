module SimpleFile

  # CSV
  class CSV

    include SimpleFile::Stream::File

    MalformedCSVError = Class.new StandardError
    NotFileTypeError  = Class.new StandardError

    attr_accessor :file, :col_sep, :encoding, :count, :errors, :results, :mapping

    def initialize(*args)
      options   = args.extract_options!
      @encoding = options.delete(:encoding) { 'iso-8859-1:utf-8' }
      @col_sep  = options.delete(:col_sep)  { ',' }
      @mapping  = options.delete(:mapping)  { {} }
    end

    def import(obj)
      prep_file(obj)
      self.results =
        file.collect { |row| Hash[*map_fields(row).flatten] }
    rescue StandardError => e
      self.errors = e
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

    def prep_file(obj)
      self.file    = read_file(obj)
      self.mapping = format_mapping
      self.count   = file.count
    rescue ::CSV::MalformedCSVError
      quote_chars.empty? ? raise : retry
    end

    def format_mapping
      Hash[*headers.zip(headers).flatten].transform_keys!(&:to_s).
        merge(@mapping.transform_keys!(&:to_s))
    end

    def read_file(obj)
      raise NotFileTypeError unless obj.is_a? File
      ::CSV.parse(obj.read, col_sep: col_sep, headers: :first_row,
                            row_sep: :auto, quote_char: quote_chars.shift,
                            encoding: encoding)
    end

    def quote_chars
      %w[" | ~ ^ & *]
    end

  end

end
