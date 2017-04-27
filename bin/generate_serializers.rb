Dir["app/models/*.rb"].reject { |path| path =~ /application_record/ }.each do |path|
  name = File.basename(path).gsub(File.extname(path), '')
  `bin/rails generate serializer #{name}`
end
