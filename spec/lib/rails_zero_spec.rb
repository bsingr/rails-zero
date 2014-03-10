require 'spec_helper'

describe RailsZero do
  it 'returns config' do
    described_class.config.should be_kind_of(RailsZero::Config)
  end

  it 'configures' do
    expect { |b| described_class.configure(&b) }.to \
      yield_with_args(described_class.config)
  end
end
