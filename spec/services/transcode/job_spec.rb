require 'spec_helper'
require './app/services/transcode/job'

module Transcode
  RSpec.describe Job, type: :service do
    subject do
      described_class.new input: 'video.mp4'
    end

    it 'substitutes output key extension for determined one' do
      expect(subject.output_id).to eq('video.m3u8')
    end

    it 'turns presets into output params' do
      key =
        "hls#{Transcode::Job::VIDEO_PRESETS.keys.first}/#{subject.output_id}"
      output = subject.outputs.first
      expect(output).to be_a(Hash)
      expect(output[:key]).to \
        eq(key)
      expect(output[:preset_id]).to \
        eq(Transcode::Job::VIDEO_PRESETS.values.first)
      expect(output[:segment_duration]).to \
        eq(Transcode::Job::SEGMENT_DURATION)
    end

    it 'builds playlist params' do
      expect(subject.playlist[:name]).to eq subject.output_id
      expect(subject.playlist[:format]).to \
        eq(Transcode::Job::FORMAT)
      expect(subject.playlist[:output_keys].first).to \
        include(Transcode::Job::VIDEO_PRESETS.keys.first)
    end

    it 'tests validation' do
      expect(subject).to be_valid
    end

    it 'tests persistence' do
      subject.instance_variable_set '@persisted', true
      expect(subject).to be_persisted
    end

    it 'creates elastic transcoder job and tests persistence' do
      subject.instance_variable_set '@persisted', nil
      allow(subject.send(:transcoder)).to \
        receive(:create_job)
        .with(subject.attributes)
        .and_return(double(success?: true))
      expect(subject.save).to be true
      expect(subject).to be_persisted
    end
  end
end
