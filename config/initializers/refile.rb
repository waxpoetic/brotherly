# frozen_string_literal: true

credentials = Rails.application.secrets.aws_access_key_id.present? &&
              Rails.application.secrets.aws_secret_access_key.present? &&
              Rails.application.secrets.aws_region.present? &&
              Rails.application.secrets.cdn_domain_name.present?

if defined?(Refile::S3) && credentials
  aws = {
    access_key_id: Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region: Rails.application.secrets.aws_region,
    bucket: Rails.application.secrets.cdn_domain_name
  }
  Refile.cache = Refile::S3.new prefix: 'cache', **aws
  Refile.store = Refile::S3.new prefix: 'store', **aws
  Refile.cdn_host = 'http://' + Rails.application.secrets.cdn_domain_name
end
