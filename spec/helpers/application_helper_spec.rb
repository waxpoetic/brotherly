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
end
