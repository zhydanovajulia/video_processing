namespace :grape do
  desc "routes"
  task :routes => :environment do
    ::API.routes.each do |api|
      method = api.request_method.ljust(10)
      path = api.path
      puts "#{method} #{path}"
    end
  end
end
