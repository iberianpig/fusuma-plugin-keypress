# frozen_string_literal: true

module Fusuma
  module Plugin
    module Buffers
      # Buffer events having KeypressRecord
      class KeypressBuffer < Buffer
        DEFAULT_SOURCE = 'keypress_parser'

        # @param event [Event]
        def buffer(event)
          return if event&.tag != source

          @events.push(event)
          @events.clear if released?
        end

        def empty?
          @events.empty?
        end

        private

        def released?
          true if @events.last.record.status =~ /released/
        end
      end
    end
  end
end
