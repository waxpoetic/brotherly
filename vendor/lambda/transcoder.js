'use strict';

console.log('Loading function');

const aws = require('aws-sdk');

const s3 = new aws.S3({ apiVersion: '2006-03-01' });
const elasticTranscoder = new aws.ElasticTranscoder({ apiVersion: '2012-09-25' });


exports.handler = (event, context, callback) => {
    //console.log('Received event:', JSON.stringify(event, null, 2));

    // Get the object from the event and show its content type
    const bucket = event.Records[0].s3.bucket.name;
    const key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' '));
    const params = {
        Bucket: bucket,
        Key: key,
    };
    s3.getObject(params, (err, data) => {
        if (err) {
            console.log(err);
            const message = `Error getting object ${key} from bucket ${bucket}. Make sure they exist and your bucket is in the same region as this function.`;
            console.log(message);
            callback(message);
        } else {
            console.log('CONTENT TYPE:', data.ContentType);
            /*
                '400k' => '1351620000001-200050',
                '600k' => '1351620000001-200040',
                '1000k' => '1351620000001-200030',
                '1500k' => '1351620000001-200020',
                '2000k' => '1351620000001-200010'
            */
            console.log('Transcoding file', key);
            elasticTranscoder.createJob({
                PipelineId: '1477977126515-j3oa1g',
                Input: {
                    Key: key
                },
                Outputs: [
                    {
                        Key: '400k',
                        PresetId: '1351620000001-200050',
                        SegmentDuration: '2.0'
                    },
                    {
                        Key: '600k',
                        PresetId: '1351620000001-200040',
                        SegmentDuration: '2.0'
                    },
                    {
                        Key: '1000k',
                        PresetId: '1351620000001-200030',
                        SegmentDuration: '2.0'
                    },
                    {
                        Key: '1500k',
                        PresetId: '1351620000001-200020',
                        SegmentDuration: '2.0'
                    },
                    {
                        Key: '2000k',
                        PresetId: '1351620000001-200010',
                        SegmentDuration: '2.0'
                    }
                ],
                Playlists: [
                    {
                      Format: 'HLSv3',
                      Name: data.key+'.m3u8',
                      OutputKeys: [
                        '400k',
                        '600k',
                        '1000k',
                        '1500k',
                        '2000k'
                      ]
                    }
                ]
            });

            callback(null, data.ContentType);
        }
    });
};
