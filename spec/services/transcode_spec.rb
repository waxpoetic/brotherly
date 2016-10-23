# frozen_string_literal: true
require 'spec_helper'
require './app/services/transcode'

RSpec.describe Transcode, type: :service do
  let :attachment_id do
    SecureRandom.hex
  end

  let :episode_slug do
    'episode-name'
  end

  subject do
    described_class.new attachment_id, episode_slug
  end

  def assigns(name)
    subject.instance_variable_get("@#{name}")
  end

  it 'turns presets into output params' do
    output = subject.outputs.first
    expect(output).to be_a(Hash)
    expect(output[:key]).to eq(Transcode::VIDEO_PRESETS.keys.first)
    expect(output[:preset_id]).to eq(Transcode::VIDEO_PRESETS.values.first)
    expect(output[:segment_duration]).to eq(Transcode::SEGMENT_DURATION)
  end

  it 'builds playlist params' do
    expect(subject.playlist[:name]).to eq episode_slug
    expect(subject.playlist[:format]).to eq Transcode::FORMAT
    expect(subject.playlist[:output_keys]).to eq(Transcode::VIDEO_PRESETS.keys)
  end

  it 'builds full set of attributes' do
    expect(subject.attributes[:pipeline_id]).to eq(
      Rails.application.secrets.aws_transcoder_pipeline_id
    )
    expect(subject.attributes[:input][:key]).to eq(assigns(:input))
    expect(subject.attributes[:output_key_prefix]).to eq(assigns(:output_prefix))
    expect(subject.attributes[:outputs]).to eq(subject.outputs)
    expect(subject.attributes[:playlists]).to include(subject.playlist)
  end

  it 'creates elastic transcoder job and tests persistence' do
    expect(subject.send(:transcoder)).to be_a(Aws::ElasticTranscoder::Client)
    allow(subject.send(:transcoder)).to \
      receive(:create_job)
      .with(subject.attributes)
      .and_return(double(successful?: true))
    expect(subject.save).to be true
  end
end
