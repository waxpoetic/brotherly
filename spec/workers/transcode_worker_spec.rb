require "rails_helper"

RSpec.describe TranscodeWorker, type: :worker do
  let :pipeline_id do
    '12345'
  end

  let :path do
    'test.mp3'
  end

  let :new_path do
    'test.m3u8'
  end

  it "creates a job on aws" do
    allow(model).to receive(:path).and_return(path)
    allow(worker).to receive(:pipeline_id).and_return(pipeline_id)
    allow(worker).to receive(:new_extension).and_return('m3u8')
    allow(worker.transcoder).to(
      receive(:create_job).with(
        pipeline_id: pipeline_id,
        input: { key: path },
        output: { key: new_path }
      ).and_return(true)
    )

    expect(worker.perform).to eq true
  end

  it "must implement a pipeline_id" do
    expect { worker.pipeline_id }.to raise_error
  end

  it "must implement a new_extension" do
    expect { worker.new_extension }.to raise_error
  end

  it "converts to new transcode path" do
    expect(worker.transcode_path).to eq(new_path)
  end

  it "instantiates a transcoder" do
    expect(subject).to respond_to(:transcoder)
  end

  it "saves off secrets into a method" do
    expect(subject.send :secrets).not_to be nil
  end
end
