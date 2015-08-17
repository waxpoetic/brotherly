require "refile/s3"

aws = {
  access_key_id: Rails.application.secrets.aws_access_key_id,
  secret_access_key: Rails.application.secrets.secret_access_key,
  region: Rails.application.config.aws_region_name,
  bucket: Rails.application.config.aws_bucket_name
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
Refile.host = "//#{Rails.application.config.asset_host}"
