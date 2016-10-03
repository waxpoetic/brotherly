require 'rails_helper'

RSpec.describe FeaturePresenter, type: :presenter do
  let :performance do
    performances :wonderbars_one
  end

  subject do
    FeaturePresenter.new(performance)
  end

  it 'finds url to model' do
    expect(subject.url).to eq '/performances/123'
  end

  it 'finds title of model' do
    expect(subject.title).to eq 'Episode 1: The Wonder Bars'
  end

  it 'finds image url for model' do
    expect(subject.image).to eq 'performance-cover.jpg'
  end
end
