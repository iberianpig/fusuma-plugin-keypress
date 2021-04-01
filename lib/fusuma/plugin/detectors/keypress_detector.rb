# frozen_string_literal: true

module Fusuma
  module Plugin
    module Detectors
      # Detect KeypressEvent from KeypressBuffer
      class KeypressDetector < Detector
        SOURCES = ['keypress'].freeze
        BUFFER_TYPE = 'keypress'

        # Always watch buffers and detect them.
        def watch?
          true
        end

        # @param buffers [Array<Event>]
        # @return [Event] if event is detected
        # @return [NilClass] if event is NOT detected
        def detect(buffers)
          buffer = buffers.find { |b| b.type == BUFFER_TYPE }

          return if buffer.empty?

          records = buffer.events.select { |e| e.record.status == 'pressed' }.map(&:record)

          index_record = Events::Records::IndexRecord.new(
            index: create_index(records: records),
            position: :surfix
          )

          create_event(record: index_record)
        end

        # @param records [Array<Events::Records::KeypressRecord>]
        # @return [Config::Index]
        def create_index(records:)
          code = records.map(&:code).join('+')
          Config::Index.new(
            [
              Config::Index::Key.new('keypress', skippable: true),
              Config::Index::Key.new(code, skippable: true)
            ]
          )
        end
      end
    end
  end
end
