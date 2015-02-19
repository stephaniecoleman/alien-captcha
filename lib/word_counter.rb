class WordCounter

	def initialize(params)
		files = %w(texts/0 texts/1 texts/2 texts/3 texts/4 texts/5)
	  text_file = files.sample	
	  @source_text = File.read(text_file).strip
	  @source_text_array = []
	  @exclude = []
	  @include = []
	  @frequency_hash = Hash.new(0)
	  self.get_information(source_text)
	  @params = params
	end

	def sanitize_source_text
		@source_text_array = @source_text.downcase.gsub(/[^[:word:]\s]/, "").split
	end

	def get_exclude_array
		# If there is 1 word, exclude 0.If  1 < words <= 3, exclude 1. If 4 or more words, exclude 3.
		unique_words = @source_text_array.uniq
		if unique_words.count > 3
			@exclude = unique_words[0..2]
		elsif unique_words.count > 1
			@exclude = unique_words[0]
		else
			@exclude
		end
	end

	def get_include_array
		unique_words = @source_text_array.uniq
		@include = unique_words - @exclude
	end

	def count_frequency
		@source_text_array.each do |word|
			@frequency_hash[word] += 1
		end
	end

	def get_information
		sanitize_source_text
		get_exclude_and_include_arrays
		count_frequency
	end

	def compare_to_params
		params[:count]

	end

end