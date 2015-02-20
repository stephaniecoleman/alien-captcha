helpers do
	def get_source_text
		files = %w(texts/0 texts/1 texts/2 texts/3 texts/4 texts/5)
	  text_file = files.sample	
	  source_text = File.read(text_file).strip
	end

	def return_status(match)
		if match
			status 200
			body "200 OK"
		else
			status 400
			body "400 Bad Request"
		end
	end
end