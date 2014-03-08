require 'spec_helper'

describe Relais do
  it 'returns pages_config' do
    described_class.pages_config.should be_kind_of(Relais::PagesConfig)
  end

  it 'configures pages' do
    expect { |b| described_class.configure_pages(&b) }.to \
      yield_with_args(described_class.pages_config)
  end
end
