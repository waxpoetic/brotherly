# frozen_string_literal: true
require 'spec_helper'
require './app/services/transcode'

RSpec.describe Transcode, type: :service do
  subject do
    described_class.new SecureRandom.hex, 'episode-name'
  end

  it 'turns presets into output params' do
    output = subject.outputs.first
    expect(output).to be_a(Hash)
    expect(output[:key]).to eq(Transcode::VIDEO_PRESETS.keys.first)
    expect(output[:preset_id]).to eq(Transcode::VIDEO_PRESETS.values.first)
    expect(output[:segment_duration]).to eq(Transcode::SEGMENT_DURATION)
  end

  it 'builds playlist params' do
    expect(subject.playlist[:name]).to eq subject.name
    expect(subject.playlist[:format]).to eq Transcode::FORMAT
    expect(subject.playlist[:output_keys]).to eq(Transcode::VIDEO_PRESETS.keys)
  end

  it 'builds full set of attributes' do
    expect(subject.attributes[:pipeline_id]).to eq(
      Rails.application.secrets.aws_transcoder_pipeline_id
    )
    expect(subject.attributes[:input][:key]).to eq(subject.input)
    expect(subject.attributes[:output_key_prefix]).to eq(subject.output_prefix)
    expect(subject.attributes[:outputs]).to eq(subject.outputs)
    expect(subject.attributes[:playlists]).to include(subject.playlist)
  end

  it 'creates elastic transcoder job and tests persistence' do
    subject.instance_variable_set '@persisted', nil
    allow(subject.send(:transcoder)).to \
      receive(:create_job)
      .with(subject.attributes)
      .and_return(double(successful?: true))
    expect(subject.save).to be true
  end
end
