module HTTP
  class Response
    # A streamable response body, also easily converted into a string
    class Body
      def to_s
        return @contents if @contents

        raise StateError, "body is being streamed" unless @streaming.nil?

        # see issue 312
        begin
          encoding = Encoding.find @encoding
        rescue ArgumentError
          encoding = Encoding::BINARY
        end

        begin
          @streaming  = false
          @contents   = String.new("").force_encoding(encoding)

          while (chunk = @stream.readpartial)
            @contents << chunk.force_encoding(encoding) unless chunk.frozen?
          end
        rescue
          @contents = nil
          raise
        end

        @contents
      end
    end
  end
end