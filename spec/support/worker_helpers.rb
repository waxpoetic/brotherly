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
      subject.class.new model: model
    end
  end
end
