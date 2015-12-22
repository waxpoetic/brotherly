require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let :config do
    Rails.application.config
  end

  it 'figures out page name' do
    expect(helper.page_name).to eq(controller.page_name)
  end

  it 'figures out base section name' do
    expect(helper.section_name).to \
      eq(File.basename(controller.controller_name.to_s))
  end

  it 'sets new title' do
    expect(helper.title('new title')).to be true
    expect(content_for(:title)).to eq('new title')
  end

  it 'builds title into tag' do
    expect(helper.title_tag).to eq("<title>#{config.name}</title>")
    expect(helper.title('new title')).to be true
    expect(helper.title_tag).to eq("<title>new title | #{config.name}</title>")
  end

  it 'provides the config to the view' do
    expect(helper.config).to eq(Rails.application.config)
  end
end
