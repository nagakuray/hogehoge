require 'net/http'
require 'json'
require "uri"


# res = Net::HTTP.get(URI.parse('http://www.yahoo.co.jp/'))
# puts res

url = URI.parse("http://www.yahoo.co.jp/")
res = Net::HTTP.start(url.host,url.port) do |http|
  http.get("/")
end
puts res.code
# puts res.body
res.each_header do |name,val|
  puts "#{name}: #{val}"
end
