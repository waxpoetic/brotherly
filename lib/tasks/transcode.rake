desc 'transcode all videos'
task transcode: :environment do
  s3 = Aws::S3::Client.new

  s3.list_objects(bucket: 'files.brother.ly', prefix: 'raw-videos').contents.each do |video|
    if video.key =~ /mp4\Z/
      puts "transcoding #{video.key}"
      Transcode.call(video.key)
    end
  end
end
