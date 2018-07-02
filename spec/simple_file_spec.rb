require 'spec_helper'

describe SimpleFile do
  it 'should have a version number' do
    expect(SimpleFile::VERSION).not_to be nil
  end

  it 'should have an encoding' do
    expect(SimpleFile).to respond_to(:encoding)
  end
end

