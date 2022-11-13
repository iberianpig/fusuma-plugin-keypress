# frozen_string_literal: true

require "spec_helper"

require "fusuma/plugin/filters/filter"
require "fusuma/plugin/inputs/input"

require "./lib/fusuma/plugin/filters/keypress_filter"

module Fusuma
  module Plugin
    module Filters
      RSpec.describe KeypressFilter do
        describe "#keep?" do
          before { @filter = KeypressFilter.new }
          context "with keyboard event" do
            before do
              keyboard = double(Fusuma::Device, id: "event4")
              allow(@filter).to receive(:keep_devices).and_return([keyboard])
              text = " #{keyboard.id}   KEYBOARD_KEY      +4.81s      KEY_LEFTSHIFT (42) pressed"
              @event = Events::Event.new(tag: "libinput_command_input", record: text)
              # @filter = KeypressFilter.new
            end
            it "should be true" do
              expect(@filter.keep?(@event.record)).to eq true
            end
          end
          context "with multiple keyboards" do
            before do
              keyboard1 = double(Fusuma::Device, id: "event1")
              keyboard2 = double(Fusuma::Device, id: "event2")
              allow(@filter).to receive(:keep_devices).and_return([
                keyboard1, keyboard2
              ])
              text1 = " #{keyboard1.id}   KEYBOARD_KEY      +4.81s      KEY_LEFTSHIFT (42) pressed"
              text2 = " #{keyboard2.id}   KEYBOARD_KEY      +4.81s      KEY_LEFTSHIFT (42) pressed"
              @event1 = Events::Event.new(tag: "libinput_command_input", record: text1)
              @event2 = Events::Event.new(tag: "libinput_command_input", record: text2)
            end
            it "should return multiple keyboards" do
              expect(@filter.keep?(@event1.record)).to eq true
              expect(@filter.keep?(@event2.record)).to eq true
            end
          end
          context "when touchpad events" do
            before do
              touchpad = double(Fusuma::Device, id: "event18")
              allow(@filter).to receive(:keep_devices).and_return([touchpad])
              text = " #{touchpad.id}  GESTURE_SWIPE_UPDATE  +1.44s  4 11.23/ 1.00 (36.91/ 3.28 unaccelerated) "
              #                        ^^^^^^^^^^^^^^^^^^^^  Shoud be KEYBOARD_KEY
              @event = Events::Event.new(tag: "libinput_command_input", record: text)
            end
            it "should be false" do
              expect(@filter.keep?(@event.record)).to eq false
            end
          end

          context "with plugins.filters.keypress_filter.source=CUSTOM_INPUT" do
            it { expect(@filter.source).to eq "libinput_command_input" }

            context "with config" do
              around do |example|
                @custom_source = "CUSTOM_INPUT"

                ConfigHelper.load_config_yml = <<~CONFIG
                  plugin:
                   filters:
                     keypress_filter:
                       source: #{@custom_source}
                CONFIG

                example.run

                Config.custom_path = nil
              end

              it { expect(@filter.source).to eq @custom_source }
            end
          end
          context "with config file having plugins.filters.keypress.keep_device_names='CUSTOM_KEYBOARD'" do
            it { expect(@filter.source).to eq "libinput_command_input" }

            context "with config" do
              around do |example|
                @name = "CUSTOM_KEYBOARD"

                ConfigHelper.load_config_yml = <<~CONFIG
                  plugin:
                   filters:
                     keypress_filter:
                       keep_device_names: #{@name}
                CONFIG

                example.run

                Config.custom_path = nil
              end

              it { expect(@filter.config_params[:keep_device_names]).to eq @name }
            end
          end
          context "with config file having plugins.filters.keypress.keep_device_names=['INTERNAL_KEYBOARD','EXTERNAL_KEYBOARD']" do
            it { expect(@filter.source).to eq "libinput_command_input" }

            context "with config" do
              around do |example|
                @name1 = "INTERNAL_KEYBOARD"
                @name2 = "EXTERNAL_KEYBOARD"

                ConfigHelper.load_config_yml = <<~CONFIG
                  plugin:
                   filters:
                     keypress_filter:
                       keep_device_names:
                        - #{@name1}
                        - #{@name2}
                CONFIG

                example.run

                Config.custom_path = nil
              end

              it { expect(@filter.config_params(:keep_device_names)).to eq [@name1, @name2] }
            end
          end
        end
      end
    end
  end
end
