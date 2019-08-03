# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  it 'renders about page' do
    get :about

    expect(response).to be_successful
  end
end
