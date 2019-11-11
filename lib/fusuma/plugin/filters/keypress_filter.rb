# frozen_string_literal: true

module Fusuma
  module Plugin
    module Filters
      # filter keyboard events from libinput debug-events
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
