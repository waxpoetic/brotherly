# frozen_string_literal: true

desc 'transcode all videos'
task transcode: :environment do
  s3 = Aws::S3::Client.new
  dir = s3.list_objects(bucket: 'files.brother.ly', prefix: 'raw-videos/evening with mr jennings')
  dir.contents.each do |video|
    if /mp4\Z/.match?(video.key)
      puts "transcoding #{video.key}"
      Transcode.call(video.key)
    end
  end
end
