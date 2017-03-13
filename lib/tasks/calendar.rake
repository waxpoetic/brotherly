namespace :calendar do
  desc 'Authorize access with the Google Calendar API'
  task authorize: :environment do
    if Event.calendar.authorized?
      puts 'You are already authorized.'
    else
      puts "Open this URL and input the code: #{Event.calendar.authorize_url}"
      code = STDIN.gets.chomp
      Event.calendar.login(code)
      puts 'Calendar has been authorized'
    end
  end
end
