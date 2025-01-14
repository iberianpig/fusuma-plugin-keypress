# frozen_string_literal: true

module Fusuma
  module Plugin
    module Events
      module Records
        # Record for Keypress event
        class KeypressRecord < Record
          attr_reader :status, :code, :layer

          # @example
          #  KeypressRecord.new(status: 'pressed', code: 'LEFTSHIFT', layer: 'thumbsense')
          #
          # @param status [String] 'pressed' or 'released'
          # @param code [String]
          # @param layer [Hash] this field will be used from other plugin.
          def initialize(status:, code:, layer: nil)
            super()
            @status = status
            @code = code
            @layer = layer
          end

          def to_s
            case layer
            when {}
              "#{status} #{code}"
            else
              "#{status} #{code} #{layer}"
            end
          end
        end
      end
    end
  end
end
