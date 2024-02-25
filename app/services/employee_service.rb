require 'net/http'
require 'net/https'

class EmployeeService
  BASE_URL = 'https://dummy-employees-api-8bad748cda19.herokuapp.com/employees'

  def self.fetch_all(page = nil)
    uri = URI(page.present? ? "#{BASE_URL}?page=#{page}" : BASE_URL)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.fetch(id)
    uri = URI("#{BASE_URL}/#{id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.create(params)
    uri = URI(BASE_URL)
    response = post(uri, params)
    JSON.parse(response)
  end
  
  def self.update(id, params)
    uri = URI("#{BASE_URL}/#{id}")
    response = put(uri, params)
    JSON.parse(response)
  end

  private

  def self.post(uri, params)
    request(uri, Net::HTTP::Post, params)
  end

  def self.put(uri, params)
    request(uri, Net::HTTP::Put, params)
  end

  def self.request(uri, request_class, params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    request = request_class.new(uri.path)
    request['Content-Type'] = 'application/json'
    request.body = params.to_json
    response = http.request(request)
    response.body
  end
end