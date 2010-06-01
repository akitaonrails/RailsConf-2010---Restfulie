desc "Resets the database"
task :reset => :environment do
  `rm #{File.expand_path('../../../db/development.sqlite3', __FILE__)}`
  Rake::Task["db:migrate"].execute
  Rake::Task["db:seed"].execute
end
