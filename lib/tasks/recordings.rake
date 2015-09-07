namespace :recordings do
  namespace :transcode do
    def transcode(kind)
      [Episode, Performance].each do |model|
        model.map(&:"transcode_#{kind}")
      end
    end

    desc "Transcode audio recordings"
    task audio: :environment do
      transcode :audio
    end

    desc "Transcode video recordings"
    task video: :environment do
      transcode :video
    end
  end

  desc "Transcode all recordings"
  task transcode: %w(
    recordings:transcode:audio
    recordings:transcode:video
  )
end
