# frozen_string_literal: true

require 'pueri'

RSpec.describe Pueri do
  it 'has a version number' do
    expect(Pueri.version).not_to be nil
    expect(Pueri.version).to be_a String
  end
end
