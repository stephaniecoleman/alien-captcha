require 'bundler'
Bundler.require

require './helpers/app_helper.rb'
require './lib/captcha.rb'
require './lib/validator.rb'

get '/' do
	source_text = get_source_text
	captcha = Captcha.new(source_text)
	exclude = captcha.get_excluded_array
  erb :get, locals: { source_text: source_text, exclude: exclude}
end

post '/' do
	validator = Validator.new(params)
	valid_request = validator.check_for_keys
	match = false
	if valid_request
		captcha = Captcha.new(params[:source_text], params[:exclude])
		captcha.get_included_array
		captcha.get_word_frequency
		match = captcha.check_for_match(params[:words])
	end
	return_status(match)
end
