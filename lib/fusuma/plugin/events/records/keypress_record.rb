# frozen_string_literal: true

module Fusuma
  module Plugin
    module Events
      module Records
        # Record for Keypress event
        class KeypressRecord < Record
          attr_reader :status, :code

          # @param status [String]
          def initialize(status:, code:)
            @status = status
            @code = code
            super()
          end
        end
      end
    end
  end
end
