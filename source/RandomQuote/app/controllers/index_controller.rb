class IndexController < ApplicationController

	require 'Pixabay_API'

	helper_method :find_query
	helper_method :call_api

	def find_query(quote)		# Search for image based on largest word of quote. (I know I'm stupid!)
		words = quote.split(/\W+/)
		searchword = "Hi"
		words.each do |word|
			if word.size > searchword.size
				searchword = word
			end
		end
		puts "searchword : " + searchword
		return call_api(searchword)
	end

	def call_api(query)
		# If no results were found for original query, use one of the keyword as query
		keywords = ["nature", "environment", "parks", "destinations", "scenic", "night", "milky way", "breathtaking"]
		begin
		 	@api_resp, @cite_resp = Pixabay_API.new.api_call(query)
		 	if @api_resp == ""
		 		puts "NO RESULTS"
		 		query = keywords[rand(keywords.size)]
		 		@api_resp, @cite_resp = Pixabay_API.new.api_call(query)
		 	end
		 	puts "api_resp = " + @api_resp
		 	puts "cite_resp = " + @cite_resp
			rescue
				puts ("Exception in API call")
			end
		return @api_resp, @cite_resp
	end

end
