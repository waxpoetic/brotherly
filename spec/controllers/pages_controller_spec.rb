# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  it 'renders home page' do
    get :home

    expect(response).to be_success
  end
end
