Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV['APPLICATION_HOST'] || '127.0.0.1'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete]
  end
end
