require 'httparty'

class Pixabay_API

	def api_call(lookfor)
		puts("query: " + lookfor)						# https://pixabay.com/api/docs/
		api_key = '*******-*************************'	# your pixabay api key
		begin 											# https://stackoverflow.com/questions/7909596/how-can-i-handle-errors-with-httparty
			response = HTTParty.get('https://pixabay.com/api', query: {q: lookfor, key: api_key, safesearch: "true", editors_choice: "true"})
			case response.code
			when 200									# upon success
				puts "api-request: " + response.request.last_uri.to_s
				urls = Array.new
				cite = Array.new
				res = response.parsed_response["hits"]	# parsing the json response
				res.each do |resp|
					urls.push(resp["webformatURL"])
					cite.push(resp["pageURL"])
				end
		#		puts urls
				tot = urls.size
				if tot == 0
					return ""
				end
				temp_ind = rand([tot,20].min)			# randomly select one of min(total, first 20) number of images
				retval = urls.at(temp_ind)				# JSON shows only shows 20 results although docs says otherwise
				puts("retval: " + retval.to_s)
				return retval, cite.at(temp_ind)		# return URL of image and URL of this image on pixabay site
			else
				return ""
			end
		rescue HTTParty::Error
			puts "HTTParty Error"
		rescue StandardError
			puts "Standard Connection errors"
		rescue
			puts "Any other error"
		end
		return ""
	end

end