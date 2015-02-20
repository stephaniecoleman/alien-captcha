require "pry"
require "sinatra"
require "sinatra/reloader" if development?
require "./helpers/app_helper.rb"
require "./lib/captcha.rb"

get '/' do
	source_text = get_source_text
	captcha = Captcha.new(source_text)
	exclude = captcha.get_excluded_array
	included = captcha.unique_words - exclude

  erb :get, locals: { source_text: source_text, exclude: exclude, included: included }
end

post '/' do
	captcha = Captcha.new(params[:source_text])
	captcha.get_word_frequency
	match = captcha.check_for_match(params[:words])
	return_status(match)
end


# use key for every request. 
# stateless transferring of info