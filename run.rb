require 'base64'
require 'json'
require 'net/https'
require "open-uri"


IMAGE_URL = 'http://XXXXXXXXXXXXXXXXXX.jpg'

API_KEY = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
API_URL = "https://vision.googleapis.com/v1/images:annotate?key=#{API_KEY}"

image = open(IMAGE_URL)

base64_image = Base64.strict_encode64(File.new(image, 'rb').read)

body = {
  requests: [{
    image: {
      content: base64_image
    },
    features: [
      {
        type: 'TEXT_DETECTION',
        maxResults: 15
      }
    ]
  }]
}.to_json

uri = URI.parse(API_URL)
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri)
request["Content-Type"] = "application/json"
response = https.request(request, body)

puts response.body