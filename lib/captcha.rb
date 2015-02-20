require 'pry'

class Captcha
	attr_reader :unique_words

	def initialize(source_text, exclude = [])
		@sanitized_array = source_text.downcase.gsub(/[^[:word:]\s]/, "").split
		@unique_words = @sanitized_array.uniq
		@word_frequency_hash = Hash.new(0)
		@exclude = exclude
		@included = []
	end

	def get_excluded_array
		if @unique_words.count > 3
			@exclude = @unique_words[0..2]
		elsif @unique_words.count > 1
			@exclude << @unique_words[0]
		else
			@exclude
		end
	end

	def get_included_array
		@included = @unique_words - @exclude
	end

	def get_word_frequency
		@sanitized_array.each do |word|
			if @included.include?(word)
				@word_frequency_hash[word] += 1
			end
		end
		@word_frequency_hash
	end

	def check_for_match(answer_hash)
		match = true
		@word_frequency_hash.each do |key, value|
			if value != answer_hash[key].to_i
				return false
			end
		end
		match
	end

end