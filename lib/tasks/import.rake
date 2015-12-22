require 'csv'

namespace :import do
  desc 'Import a list of subscriber names and emails from a CSV'
  task subscribers: :environment do
    csv_file = Rails.root.join 'db', 'import', 'subscribers.csv'
    fail "Download #{csv_file} from MailChimp" unless File.exist? csv_file
    CSV.foreach csv_file do |row|
      unless row[1] == 'Name' && row[2] == 'Email'
        Subscriber.create name: row[1], email: row[2]
      end
    end
  end
end
