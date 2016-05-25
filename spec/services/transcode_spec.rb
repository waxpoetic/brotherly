require 'spec_helper'
require './app/services/transcode'

RSpec.describe Transcode, type: :service do
  subject { described_class.new }

  context 'audio' do
    let :pipeline_id do
      Rails.application.secrets.aws_audio_pipeline_id
    end

    before do
      subject.pipeline = :audio
      subject.input = 'audio.wav'
    end

    it 'reads pipeline id from secrets' do
      expect(subject.pipeline_id).to eq pipeline_id
    end

    it 'determines new extension' do
      subject.pipeline = :audio
      expect(subject.extension).to eq 'mp3'
    end

    it 'substitutes output key extension for determined one' do
      expect(subject.output).to eq(subject.input.gsub(/wav/, 'mp3'))
    end

    it 'creates audio transcoder job' do
      allow(subject.send(:transcoder)).to \
        receive(:create_job)
        .with(subject.params)
        .and_return(double(success?: true))
      expect(subject.save).to be true
    end
  end

  context 'video' do
    let :pipeline_id do
      Rails.application.secrets.aws_video_pipeline_id
    end

    before do
      subject.pipeline = :video
      subject.input = 'video.flv'
    end

    it 'reads pipeline id from secrets' do
      expect(subject.pipeline_id).to eq pipeline_id
    end

    it 'determines new extension' do
      subject.pipeline = :video
      expect(subject.extension).to eq 'm3u8'
    end

    it 'substitutes output key extension for determined one' do
      expect(subject.output).to eq(subject.input.gsub(/flv/, 'm3u8'))
    end

    it 'creates audio transcoder job' do
      allow(subject.send(:transcoder)).to \
        receive(:create_job)
        .with(subject.params)
        .and_return(double(success?: true))
      expect(subject.save).to be true
    end
  end
end
