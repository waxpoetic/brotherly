require 'rails_helper'

RSpec.describe Search, type: :model do
  let :artist do
    artists :rnd
  end

  let :query do
    artist.name[0..2]
  end

  let :documents do
    [double(searchable_id: artist.id, searchable_type: artist.class.name)]
  end

  subject do
    described_class.new query: query
  end

  before do
    allow(PgSearch).to receive(:multisearch).with(query).and_return(documents)
  end

  it 'initializes with query and empty documents' do
    expect(subject.query).to eq query
    expect(subject.documents).to be_empty
  end

  it 'validates and performs search' do
    expect(subject.save).to be true
  end

  it 'returns models as a collection of results' do
    allow(subject).to receive(:documents).and_return(documents)
    expect(subject.results).to be_any
    expect(subject.results).to include(artist)
  end

  it 'finds all model classes' do
    allow(subject).to receive(:documents).and_return(documents)
    expect(subject.send :models).to include(artist.class.name)
  end

  it 'runs multisearch on query to find documents' do
    expect(subject.send :create).to be true
  end
end
