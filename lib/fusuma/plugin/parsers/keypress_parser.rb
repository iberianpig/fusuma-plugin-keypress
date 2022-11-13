# frozen_string_literal: true

module Fusuma
  module Plugin
    module Parsers
      # Generate KeypressRecord from libinput_command_input
      class KeypressParser < Parser
        DEFAULT_SOURCE = "libinput_command_input"

        # @param record [String]
        # @return [Records::Gesture, nil]
        def parse_record(record)
          line = record.to_s

          # NOTE: example of line
          # event4   KEYBOARD_KEY      +4.81s      KEY_LEFTSHIFT (42) pressed
          # event4   KEYBOARD_KEY      +4.90s      KEY_LEFTSHIFT (42) released
          # event4   KEYBOARD_KEY      +7.39s      KEY_CAPSLOCK (58) pressed
          # event4   KEYBOARD_KEY      +7.52s      KEY_CAPSLOCK (58) released
          # event4   KEYBOARD_KEY      +8.98s      KEY_LEFTCTRL (29) pressed
          # event4   KEYBOARD_KEY      +9.14s      KEY_LEFTCTRL (29) released

          case line
          when /KEYBOARD_KEY.+(\d+\.\d+)s.*KEY_([A-Z]+).*(pressed|released)/
            matched = Regexp.last_match
            # time = matched[1]   # 4.81
            code = matched[2] # LEFTSHIFT
            status = matched[3] # pressed

            Events::Records::KeypressRecord.new(status: status, code: code)
          end
        end

        def tag
          "keypress_parser"
        end
      end
    end
  end
end
