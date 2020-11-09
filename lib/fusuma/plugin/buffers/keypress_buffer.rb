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
        end

        def clear_expired(*)
          return if @events.empty?

          if released?
            released_code = @events.last.record.code
            @events.delete_if { |e| e.record.code == released_code }
          end
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
