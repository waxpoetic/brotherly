require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe '#index' do
    it 'enumerates through all found events' do
      expect(assigns(:events)).to be_any
    end
  end

  describe '#show' do
    let :event do
      Event.first
    end

    it 'finds event by id' do
      get :show, id: event.id

      expect(assigns(:event)).to be_present
      expect(assigns(:event)).to eq(event)
      expect(response).to be_success
    end

    it 'returns 404 when event not found' do
      get :show, id: 'nil'

      expect(assigns(:event)).not_to be_present
      expect(response.status).to eq(404)
    end
  end
end
