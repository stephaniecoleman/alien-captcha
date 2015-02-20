class Validator

	def initialize(params)
		@params = params
	end

	def check_for_keys
		valid_request = true
		["source_text", "words", "exclude"].each do |key|
			if !@params.has_key?(key)
				return false
			end
		end
		valid_request
	end

end