require 'pry'

class Captcha
	attr_reader :unique_words

	def initialize(source_text)
		@sanitized_array = source_text.downcase.gsub(/[^[:word:]\s]/, "").split
		@unique_words = @sanitized_array.uniq
		@word_frequency_hash = Hash.new(0)
		@exclude = []
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

	def get_word_frequency
		@sanitized_array.each do |word|
			@word_frequency_hash[word] += 1
		end
		@word_frequency_hash
	end

	def check_for_match(answer_hash)
		answer_hash.each do |key, value|
			if value.to_i != @word_frequency_hash[key]
				return match = false
			end
		end
		match = true
	end

end