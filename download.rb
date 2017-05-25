require 'json'
require 'uri'
require 'net/http'
require './api.rb'

api = API.new
while true
  # Set input information
  uri = URI.parse("http://localhost:9292/download/execute")
  header = {'Content-Type': 'application/json'}
  obj = { username: 'alan' }

  # Create the HTTP objects
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = obj.to_json

  # Send the request to our server to update info
  response = http.request(request)
  if response.code != '200'
    puts 'Nothing to download'
  else
    # Download files with Drive API
    gaccount, gfid, dst_path = response.body.split(/[ ]/)
    Setting.api.call('download', gaccount, gfid, dst_path)
  end
end
