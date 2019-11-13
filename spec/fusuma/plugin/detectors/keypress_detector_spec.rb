# frozen_string_literal: true

require 'spec_helper'

require 'fusuma/plugin/detectors/detector.rb'
require 'fusuma/plugin/buffers/buffer.rb'

require './lib/fusuma/plugin/buffers/keypress_buffer.rb'
require './lib/fusuma/plugin/detectors/keypress_detector.rb'

module Fusuma
  module Plugin
    module Detectors
      RSpec.describe KeypressDetector do
        before do
          @detector = KeypressDetector.new
          @buffer = Buffers::KeypressBuffer.new
        end

        describe '#detector' do
          context 'with no keypress event in buffer' do
            before do
              @buffer.clear
            end

            it { expect(@detector.detect([@buffer])).to eq nil }
          end
        end

        context 'with keypress events in buffer' do
          before do
            record = Events::Records::KeypressRecord.new(status: 'pressed', code: 'LEFTSHIFT')
            event = Events::Event.new(tag: 'keypress_parser', record: record)

            @buffer.buffer(event)
          end
          it { expect(@detector.detect([@buffer])).to be_a Events::Event }
          it { expect(@detector.detect([@buffer]).record).to be_a Events::Records::IndexRecord }
          it { expect(@detector.detect([@buffer]).record.index).to be_a Config::Index }

          it 'should detect LEFTSHIFT' do
            expect(@detector.detect([@buffer]).record.index.keys.map(&:symbol))
              .to eq(%i[keypress LEFTSHIFT])
          end
        end

        context 'with two different keypress events in buffer' do
          before do
            record1 = Events::Records::KeypressRecord.new(status: 'pressed', code: 'LEFTSHIFT')
            record2 = Events::Records::KeypressRecord.new(status: 'pressed', code: 'LEFTCTRL')
            event1 = Events::Event.new(tag: 'keypress_parser', record: record1)
            event2 = Events::Event.new(tag: 'keypress_parser', record: record2)

            @buffer.buffer(event1)
            @buffer.buffer(event2)
          end

          it 'should detect LEFTSHIFT+LEFTCTRL' do
            expect(@detector.detect([@buffer]).record.index.keys.map(&:symbol))
              .to eq(%i[keypress LEFTSHIFT+LEFTCTRL])
          end
        end
      end
    end
  end
end
