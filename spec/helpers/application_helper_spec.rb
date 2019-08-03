# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let :config do
    Rails.application.config
  end

  it 'figures out page name' do
    expect(helper.page_name).to eq(controller.action_name.to_s)
  end

  it 'figures out base section name' do
    expect(helper.section_name).to \
      eq(File.basename(controller.controller_name.to_s))
  end

  it 'provides the config to the view' do
    expect(helper.config).to eq(Rails.application.config)
  end

  it 'returns the copyright year date range' do
    expect(helper.copyright_year).to eq("2015 - #{Time.zone.now.year}")
  end

  it 'creates a nav link with active class' do
    allow(helper).to receive(:current_page?).with('/bar').and_return(true)
    expect(helper.nav_link_to(:foo, '/bar')).to eq(
      %(<a class="active" href="/bar"><span class="translation_missing" title="translation missing: en.titles.pages.foo">Foo</span></a>)
    )
  end

  it 'finds active class for route' do
    allow(helper).to receive(:current_page?).with('foo').and_return(true)
    expect(helper.send(:active_class_for, 'foo')).to eq('active')
    allow(helper).to receive(:current_page?).with('foo').and_return(false)
    expect(helper.send(:active_class_for, 'foo')).to eq(nil)
  end

  xit 'returns home page slideshow settings' do
    expect(helper.home_page_slideshow_settings([])).to \
      eq({ autoplay: true }.to_json)
    expect(helper.home_page_slideshow_settings(['test'])).to \
      eq({ autoplay: false }.to_json)
  end
end
