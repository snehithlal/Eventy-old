namespace :seed do
  desc 'Generate an empty seed file, Usage => rake seed:create seed_name'
  task create: :environment do
    argument = ARGV[1]
    argument = "_#{ARGV[1]}" if argument.present?
    seed_path = "db/seeds/#{Time.now.to_i}#{argument}_seed.rb"
    FileUtils.touch(seed_path)
    exit
  end
end