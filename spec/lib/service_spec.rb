require 'spec_helper'
require 'service'

RSpec.describe Service, type: :lib do
  it 'can set its remote class' do
    expect(subject.remote(Object)).to eq(true)
    expect(subject.remote_object).to eq(Object)
  end

  it 'can set its local name' do
    expect(subject.local(:name)).to eq(true)
    expect(subject.local_name).to eq(:name)
  end

  it 'can set its attribute name' do
    expect(subject.param(:attribute)).to eq(true)
    expect(subject.attribute_name).to eq(:attribute)
  end

  it 'has a default attribute name' do
    expect(subject.attribute_name).to eq(:service_url)
  end

  context 'with an instance' do
    let :local do
      double 'Model', attributes: { name: 'test' }
    end

    subject do
      Service.new(local)
    end

    before do
      allow(Service).to receive(:local_name).and_return(:episode)
    end

    it 'validates attributes before saving' do
      expect(subject).to be_valid
    end

    it 'is backed by a local record' do
      subject.local = nil
      expect(subject).not_to be_valid
    end

    it 'uses local alias when configured' do
      expect(subject.episode).to eq(subject.remote)
    end

    it 'does not create remote record immediately' do
      expect(subject).not_to be_persisted
      expect(subject.remote).not_to be_present
    end

    it 'delegates all attributes passed to remote to the local record' do
      expect(subject.attributes).to eq(local.attributes)
    end

    context 'when saved' do
      let :remote do
        double 'Remote', save: true, url: 'http://example.com'
      end

      let :remote_object do
        double 'Class', new: remote
      end

      before do
        allow(Service).to receive(:remote_object).and_return(remote_object)
      end

      before { subject.save }

      it 'creates the remote record' do
        expect(subject.remote).to be_present
      end

      it 'delegates url to remote' do
        expect(subject.url).to eq(remote.url)
      end

      it 'marks as persisted when the remote is present' do
        expect(subject).to be_persisted
      end
    end
  end
end
