# frozen_string_literal: true

# This is intended to be run on developer machines, and gets them set up
# with the same data that exists on production. Given how many images we
# have, it may take a while to run.

puts "-- seed '#{Rails.env}' with data from production"

Brotherly::Seed.each do |seed|
  if seed.response.success?
    seed.clear!
    seed.data.each do |params|
      record = model.create(params)
      puts record.errors.full_messages.to_sentence unless record.valid?
    end
  end
end

puts '-- done'
