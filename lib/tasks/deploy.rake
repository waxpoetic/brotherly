namespace :deploy do
  desc 'Notify Campfire of new deployment'
  task notification: :environment do
    Bro::Message.create(
      "#{Brotherly.version} has been deployed to #{Brotherly.secrets.domain_name}"
    )
  end
end
