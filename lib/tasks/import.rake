namespace :import do
  desc "Import a list of subscriber names and emails from a CSV"
  task subscribers: :environment do
    CSV.foreach 'db/import/subscribers.csv' do |row|
      Subscriber.create email: row[3]
    end
  end
end
