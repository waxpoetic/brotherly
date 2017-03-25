namespace :calendar do
  desc 'Authorize access with the Google Calendar API. This only has to be done once.'
  task authorize: :environment do
    if Event.calendar.authorized?
      puts 'You are already authorized.'
    else
      puts "Open this URL and input the code: #{Event.calendar.authorize_url}"
      code = STDIN.gets.chomp
      Event.calendar.login(code)
      puts 'Calendar has been authorized'
      puts 'Enter your credentials as $GOOGLE_CALENDAR_CLIENT_ID and $GOOGLE_CALENDAR_CLIENT_SECRET'
    end
  end
end