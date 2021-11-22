# frozen_string_literal: true

require 'fusuma/device'

module Fusuma
  module Plugin
    module Filters
      # Filter keyboard events from libinput_command_input
      class KeypressFilter < Filter
        DEFAULT_SOURCE = 'libinput_command_input'

        def config_param_types
          {
            source: String,
            keep_device_names: [Array, String]
          }
        end

        # NOTE: example of line# Select keyboard devices for filtering devices pressed/released
        # event4   KEYBOARD_KEY      +4.81s      KEY_LEFTSHIFT (42) pressed
        # event4   KEYBOARD_KEY      +4.90s      KEY_LEFTSHIFT (42) released
        # event4   KEYBOARD_KEY      +7.39s      KEY_CAPSLOCK (58) pressed
        # event4   KEYBOARD_KEY      +7.52s      KEY_CAPSLOCK (58) released
        # event4   KEYBOARD_KEY      +8.98s      KEY_LEFTCTRL (29) pressed
        # event4   KEYBOARD_KEY      +9.14s      KEY_LEFTCTRL (29) released

        # @return [TrueClass] when keeping it
        # @return [FalseClass] when discarding it
        def keep?(record)
          keep_devices.any? do |d|
            record.to_s =~ /#{d.id}\s+KEYBOARD_KEY\s/
          end
        end

        private

        # @return [Array<Fusuma::Device>]
        def keep_devices
          @keep_devices ||= KeepDevice.new(config_params(:keep_device_names)).select
        end

        # Devices to detect key presses and releases
        class KeepDevice
          def initialize(names)
            @names = names
          end

          # @return [Array<Fusuma::Device>]
          def select
            if @names
              Fusuma::Device.all.select do |d|
                Array(config_params(:keep_device_names)).any? do |name|
                  d.name =~ name
                end
              end
            else
              Fusuma::Device.all.select { |d| d.capabilities =~ /keyboard/ }
            end
          end
        end
      end
    end
  end
end
