require 'spec_helper'
require 'brotherly/service'

module Brotherly
  class TestService < Service; end
  class RemoteObject
    attr_reader :params

    def initialize(params = {})
      @params = params
    end

    def persisted?
      true
    end
  end

  RSpec.describe Service, type: :lib do
    subject { TestService }

    it 'can set its remote class' do
      expect(subject.remote(RemoteObject)).to eq(RemoteObject)
      expect(subject.remote_object).to eq(RemoteObject)
    end

    it 'can set its local name' do
      expect(subject.local(:name)).to eq(:name)
      expect(subject.local_name).to eq(:name)
    end

    it 'can set its attribute name' do
      expect(subject.attribute_name).to be nil
      expect(subject.param(:attribute)).to eq(:attribute)
      expect(subject.attribute_name).to eq(:attribute)
    end

    context 'with an instance' do
      let :local do
        double 'Model', attributes: { name: 'test' }
      end

      before do
        TestService.local(:episode)
      end

      subject do
        TestService.new(local: local)
      end

      it 'validates attributes before saving' do
        expect(subject).to be_valid
      end

      it 'is backed by a local record' do
        subject.local = nil
        expect(subject).not_to be_valid
        subject.local = :episode
      end

      it 'uses local alias when configured' do
        expect(subject.episode).to eq(subject.local)
      end

      it 'does not create remote record immediately' do
        allow(subject.send(:remote)).to receive(:persisted?).and_return(false)
        expect(subject).not_to be_persisted
      end

      it 'delegates all attributes passed to remote to the local record' do
        expect(subject.attributes).to eq(local.attributes)
      end

      context 'when saved' do
        let :remote do
          double(
            'Remote',
            save: true,
            url: 'http://example.com',
            persisted?: true
          )
        end

        let :remote_object do
          double 'Class', new: remote
        end

        before do
          allow(TestService).to \
            receive(:remote_object).and_return(remote_object)
        end

        before { subject.save }

        it 'creates the remote record' do
          expect(subject.send(:remote)).to be_present
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
end
