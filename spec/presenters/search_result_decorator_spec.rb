require 'rails_helper'

RSpec.describe SearchResultPresenter do
  let(:episode) { episodes :one }
  let(:result) do
    double(
      searchable_id: episode.id,
      searchable_type: 'Episode',
      content: episode.name
    )
  end
  subject { described_class.new result }

  it 'uses content as the name' do
    expect(subject.name).to eq(subject.model.content)
  end

  it 'finds the route to the model' do
    expect(subject.href).to include("/episodes/#{episode.id}")
  end
  it 'finds the route method for the model' do
    expect(subject.send :route).to eq('episode_url')
  end
end
