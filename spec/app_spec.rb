require "./spec/spec_helper"

describe 'The Word Counting App' do
  def app
    Sinatra::Application
  end

  it "returns 200 and has the right keys" do
    get '/'
    expect(last_response).to be_ok
    parsed_response = JSON.parse(last_response.body)
    expect(parsed_response).to have_key("text")
    expect(parsed_response).to have_key("exclude")  
  end

  it "returns 200 if count is correct" do
    post '/'
    expect(last_response).to be_ok
    parsed_response = JSON.parse(last_response.body)
    expect(parsed_response[])
  end

  it "returns 400 if the count is incorrect" do
    post '/'
    expect(last_response)
  end

end