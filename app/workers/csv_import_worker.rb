require 'csv'

class CsvImportWorker
  include Sidekiq::Worker

  def perform(user_id, file_path_string)
    user = User.find(user_id)
    file_path = Pathname.new(file_path_string)
    CSV.foreach(file_path, headers: true, encoding: 'utf-8') do |row|
      user.blogs.create(row.to_hash)
    end
  end
end