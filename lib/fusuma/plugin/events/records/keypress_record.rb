# frozen_string_literal: true

module Fusuma
  module Plugin
    module Events
      module Records
        # Record for Keypress event
        class KeypressRecord < Record
          attr_reader :status, :code

          # @example
          #  KeypressRecord.new(status: 'pressed', code: 'LEFTSHIFT')
          #
          # @param status [String]
          # @param code [String]
          def initialize(status:, code:, layer: nil)
            super()
            @status = status
            @code = code
            @layer = layer
          end

          def to_s
            "#{status} #{code}"
          end
        end
      end
    end
  end
end
