require 'csv'

namespace :import do
  desc "Import a list of subscriber names and emails from a CSV"
  task subscribers: :environment do
    CSV.foreach 'db/import/subscribers.csv' do |row|
      unless row[1] == 'Name' && row[2] == 'Email'
        Subscriber.create name: row[1], email: row[2]
      end
    end
  end
end
