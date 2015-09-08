module WorkerHelpers
  extend ActiveSupport::Concern

  included do
    let :episode do
      episodes :four
    end

    let :transcoder do
      double 'AWS::ElasticTranscoder::Client'
    end

    let :model do
      double 'Model'
    end

    let :worker do
      subject.new model: model
    end

    before do
      allow(worker).to receive(:transcoder).and_return(transcoder)
    end
  end
end
