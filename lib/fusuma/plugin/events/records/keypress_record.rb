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
          def initialize(status:, code:)
            super()
            @status = status
            @code = code
          end
        end
      end
    end
  end
end
