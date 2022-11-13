# frozen_string_literal: true

require "spec_helper"

RSpec.describe Fusuma::Plugin::Keypress do
  it "has a version number" do
    expect(Fusuma::Plugin::Keypress::VERSION).not_to be nil
  end
end
