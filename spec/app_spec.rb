require "./spec/spec_helper"

describe 'The Word Counting App' do
  def app
    Sinatra::Application
  end

  let(:correct_answer){ {"source_text"=>"The quick brown fox jumped over the lazy dog.", "exclude"=>["the", "quick", "brown"], "words"=>{"fox"=>1, "jumped"=>1, "lazy"=>1, "dog"=>1, "over"=>1}} }

  let(:incorrect_answer){ {"source_text"=>"The quick brown fox jumped over the lazy dog.", "exclude"=>["the", "quick", "brown"], "words"=>{"jumped"=>1, "lazy"=>1, "dog"=>1, "over"=>1}} }

  it "returns 200 and has the right keys" do
    get '/'
    expect(last_response).to be_ok
    parsed_response = JSON.parse(last_response.body)
    expect(parsed_response).to have_key("text")
    expect(parsed_response).to have_key("exclude")  
  end

  it "returns 200 if count is correct" do
    post '/', {"source_text"=>"The quick brown fox jumped over the lazy dog.", "exclude"=>["the", "quick", "brown"], "words"=>{"fox"=>1, "jumped"=>1, "lazy"=>1, "dog"=>1, "over"=>1}}
    expect(last_response.status).to eq(200)
  end

  it "returns 400 if count is incorrect" do
    post '/', {"source_text"=>"The quick brown fox jumped over the lazy dog.", "exclude"=>["the", "quick", "brown"], "words"=>{"fox"=>10, "jumped"=>12, "lazy"=>11, "dog"=>1, "over"=>1}}
    expect(last_response.status).to eq(400)
  end

end