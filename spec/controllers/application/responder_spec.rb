require 'rails_helper'

module Application
  RSpec.describe Responder, type: :lib do
    it 'responds to requests in a consistent manner' do
      expect(described_class.ancestors).to include(ActionController::Responder)
    end

    it 'renders flash messages from i18n' do
      expect(described_class.ancestors).to include(Responders::FlashResponder)
    end

    it 'caches json responses in http cache' do
      expect(described_class.ancestors).to include(Responders::HttpCacheResponder)
    end
  end
end
