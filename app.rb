require "pry"
require "json"
require "sinatra"
require "sinatra/reloader" if development?
require "./helpers/app_helper.rb"
require "./lib/word_counter.rb"

helpers do
	def get_source_text
		files = %w(texts/0 texts/1 texts/2 texts/3 texts/4 texts/5)
	  text_file = files.sample	
	  source_text = File.read(text_file).strip
	end

	def sanitize_text(source_text)
		sanitized_text = source_text.downcase.gsub(/[^[:word:]\s]/, "").split
	end

	def get_excluded_array(sanitized_array)
		unique_words = sanitized_array.uniq
		if unique_words.count > 3
			exclude = unique_words[0..2]
		elsif unique_words.count > 1
			exclude = [unique_words[0]]
		else
			exclude = []
		end
	end

	def get_included_array(excluded_array, sanitized_array)
		unique_words = sanitized_array.uniq
		included_array = unique_words - excluded_array
	end

	def check_for_match(params)
		frequency_hash = Hash.new(0)
		match = true
		sanitize_text(params[:source_text]).each do |word|
			frequency_hash[word] += 1
		end
		params[:words].each do |key, value|
			if value.to_i != frequency_hash[key]
				return match = false
			end
		end
		match = true
	end

end


get '/' do
	source_text = get_source_text
	sanitized_array = sanitize_text(source_text)
	excluded_array = get_excluded_array(sanitized_array)
	included_array = get_included_array(excluded_array, sanitized_array)
  erb :get, locals: { source_text: source_text, exclude: excluded_array, included: included_array }
end

post '/' do
	match = check_for_match(params)
	if match
		status 200 
		body "200 - all good!"
	else
		status 404 
		body "404 - no good!"
	end
end
