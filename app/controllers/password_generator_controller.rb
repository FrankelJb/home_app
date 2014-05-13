class PasswordGeneratorController < ApplicationController

	def create
		words = File.readlines(File.join(Rails.root, 'config', 'words.txt'))
		@password = ''
		@indices = []
		params[:password][:word_count].to_i.times do

			word = words[rand(words.count)].strip
			puts params[:password]
			if params[:password][:numbers_for_letters] == "1"
				word.gsub! 'o', '0'
				word.gsub! 'i', '1'
				word.gsub! 'z', '2'
				word.gsub! 'e', '3'
				word.gsub! 'a', '4'
				word.gsub! 's', '5'
				word.gsub! 't', '7'
				word.gsub! 'b', '8'
				word.gsub! 'g', '9'
			end

			if params[:password][:common_substitutions] == "1"
				word.gsub! 'i', '!'
				word.gsub! 'i', '1'
				word.gsub! 'a', '@'
				word.gsub! 'e', '#'
				word.gsub! '3', '#'
				word.gsub! 's', '$'
				word.gsub! '5', '$'
				word.gsub! 'x', '*'
			end
			
			if params[:password][:camel_case] == "1"
				word.capitalize!
			end
			
			if params[:password][:keep_spaces] == "1"
				if @password.length > 1
					@indices.push @password.length + 1
					@password = @password + " "
				else
					@indices.push 0
				end
			else
					@indices.push @password.length
			end

			@password = @password + word
		end

		if params[:password][:expires_in_three_months] == "1"
			time = Time.now + 3.months
			@password += time.strftime('%m%Y')
		end

		puts @password

		respond_to do |format|
			format.js
		end
	end
end
