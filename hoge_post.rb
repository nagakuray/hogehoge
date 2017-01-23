# coding: utf-8

require 'net/http'
require 'uri'

# Postするだけのかんたんなやつ
res = Net::HTTP.post_form(URI.parse('http://aaaa'),{'q' => 'ruby'})
puts res.code

# 詳細
url = URI.parse('http://aaaaa')
req = Net::HTTP::Post.new(url.path)
req.set_form_data({'from' => 'aaaaaa', 'to' => 'aaaaaaa'},'&')
res = Net::HTTP.new(url.host,url.port).start do |http|
  http.request(req)
end
puts res.code
puts res.body
