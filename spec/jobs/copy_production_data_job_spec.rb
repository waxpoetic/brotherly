require 'rails_helper'

RSpec.describe CopyProductionDataJob, type: :job do
  subject :job do
    described_class.new
  end

  it 'copies production data from the API' do
    allow(subject).to receive(:staging?).and_return(true)
    allow(Brotherly).to receive(:seeds).and_return([
      double(clear!: true, data: [])
    ])
    expect { job.perform }.not_to raise_error
  end

  it 'blocks when not on staging' do
    allow(subject).to receive(:staging?).and_return(false)
    expect { job.perform }.to raise_error
  end
end
