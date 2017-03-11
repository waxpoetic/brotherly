namespace :calendar do
  desc 'Authorize access with the Google Calendar API'
  task authorize: :environment do
    calendar = Event::Calendar.new

    if calendar.authorized?
      puts 'You are already authorized.'
    else
      puts "Open this URL and input the code: #{calendar.authorize_url}"
      code = STDIN.gets.chomp
      calendar.login(code)
      puts 'Calendar has been authorized'
    end
  end
end
