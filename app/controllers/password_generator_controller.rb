require 'net/http'

class PasswordGeneratorController < ApplicationController

	def create

		url = URI.parse('http://www.example.com/index.html')
		req = Net::HTTP::Get.new(url.path)
		res = Net::HTTP.start(url.host, url.port) {|http|
		  http.request(req)
		}

		@password = res.body
		puts @password
		respond_to do |format|
			format.js
		end
	end
end
