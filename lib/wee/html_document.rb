require 'wee/html_writer'

module Wee

  #
  # Represents a complete HTML document.
  #
  class HtmlDocument < HtmlWriter
    def initialize
      super([])
    end

    def set
      @set ||= {}
    end

    def has_divert?(tag)
      @divert and @divert[tag]
    end

    def define_divert(tag)
      raise ArgumentError if has_divert?(tag)
      @divert ||= {}
      @port << (@divert[tag] = [])
    end

    def divert(tag, txt=nil, &block)
      raise ArgumentError unless has_divert?(tag)
      raise ArgumentError if txt and block

      divert = @divert[tag]

      if txt
        divert << txt
      end

      if block
        old_port = @port
        begin
          @port = divert
          block.call
        ensure
          @port = old_port
        end
      end
    end

    def to_s
      @port.join
    end
  end
end
