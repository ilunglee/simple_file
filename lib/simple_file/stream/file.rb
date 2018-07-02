module SimpleFile

  module Stream

    # File Module
    module File

      def self.included(base)
        base.extend ClassMethods
      end

      # ClassMethods
      module ClassMethods

        METHOD_WHITELIST = %i[].freeze

        def respond_to_missing?(method_name, include_private = false)
          callable?(method_name) || super
        end

        def method_missing(method_name, *args, &block)
          callable?(method_name) ? new(*args).send(method_name, &block) : super
        end

        def callable?(method_name)
          METHOD_WHITELIST.include? method_name
        end

      end

      def encode_attr(field)
        return if field.nil?
        field.encode(SimpleFile.encoding, invalid: :replace, undef: :replace)
      end

    end

  end

end
