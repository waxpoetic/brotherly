# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GenerateSitemapJob, type: :job do
  let :sitemap do
    Rails.root.join 'public', 'sitemap.xml.gz'
  end

  it 'regenerates sitemap in the background' do
    expect { described_class.perform_now }.not_to raise_error
    expect(File.exist?(sitemap)).to be true
  end

  after do
    FileUtils.rm_rf sitemap
  end
end
