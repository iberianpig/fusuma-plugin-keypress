# frozen_string_literal: true

module Fusuma
  module Plugin
    module Filters
      # Filter keyboard events from libinput_command_input
      class KeypressFilter < Filter
        DEFAULT_SOURCE = 'libinput_command_input'

        # @return [TrueClass] when keeping it
        # @return [FalseClass] when discarding it
        def keep?(record)
          record.to_s =~ /\sKEYBOARD_KEY\s/
        end
      end
    end
  end
end
