# frozen_string_literal: true

require 'set'

module Fusuma
  module Plugin
    module Detectors
      # Detect KeypressEvent from KeypressBuffer
      class KeypressDetector < Detector
        SOURCES = %w[keypress].freeze
        BUFFER_TYPE = 'keypress'

        MODIFIER_KEYS = Set.new(%w[
                                  CAPSLOCK
                                  LEFTALT
                                  LEFTCTRL
                                  LEFTMETA
                                  LEFTSHIFT
                                  RIGHTALT
                                  RIGHTCTRL
                                  RIGHTSHIFT
                                  RIGHTMETA
                                ])

        # Always watch buffers and detect them.
        def watch?
          true
        end

        # @param buffers [Array<Event>]
        # @return [Event] if event is detected
        # @return [NilClass] if event is NOT detected
        def detect(buffers)
          keypress_buffer = find_buffer(buffers)

          return if keypress_buffer.empty?

          codes = pressed_codes(keypress_buffer.events.map(&:record))

          return if codes.empty?

          record = if codes.any? { |code| MODIFIER_KEYS.include?(code) }
                     Events::Records::IndexRecord.new(index: create_index(codes: codes),
                                                      position: :surfix)
                   else
                     Events::Records::IndexRecord.new(index: create_typing_index)
                   end

          create_event(record: record)
        end

        private

        def find_buffer(buffers)
          buffers.find { |b| b.type == BUFFER_TYPE }
        end

        def pressed_codes(records)
          codes = []
          records.each do |r|
            if r.status == 'pressed'
              codes << r.code
            else
              codes.delete_if { |code| code == r.code }
            end
          end
          codes
        end

        # @param code [String]
        # @return [Config::Index]
        def create_index(codes:)
          Config::Index.new(
            [
              Config::Index::Key.new('keypress', skippable: true),
              Config::Index::Key.new(codes.join('+'), skippable: true)
            ]
          )
        end

        # @param status [String]
        # @return [Config::Index]
        def create_typing_index
          Config::Index.new(
            [
              Config::Index::Key.new('typing')
            ]
          )
        end
      end
    end
  end
end
