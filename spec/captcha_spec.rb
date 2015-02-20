require "./spec/spec_helper"

describe Captcha do
  let(:long_text) {"Celia, you're breaking my heart, You're shaking my confidence daily. Celia, you're breaking my heart, You're shaking my confidence daily."}
  let(:answer_hash) { {"my"=>4, "heart"=>2, "shaking"=>2, "confidence"=>2, "daily"=>2} }
  let(:medium_text) {"Tomorrow and tomorrow and tomorrow."}
  let(:short_text) {"Words, words, words."}

  describe "#get_excluded_array" do
    context "with long text" do
      it "should return an array of 3 words" do
        captcha = Captcha.new(long_text)
        excluded = ["celia", "youre", "breaking"]
        expect(captcha.get_excluded_array).to eq(excluded)
      end
    end

    context "with medium text" do
      it "should return an array of one word" do
        excluded = ["tomorrow"]
        captcha = Captcha.new(medium_text)
        expect(captcha.get_excluded_array).to eq(excluded)
      end
    end

    context "with short text" do
      it "should return an empty array" do
        captcha = Captcha.new(short_text)
        expect(captcha.get_excluded_array).to be_empty
      end
    end
  end

  describe "#get_word_frequency" do
    it "should return the frequency of each word in the string" do
      captcha = Captcha.new(medium_text)
      captcha.get_excluded_array
      captcha.get_included_array
      frequency = {"and" => 2}
      expect(captcha.get_word_frequency).to eq(frequency)
    end
  end

  describe "#check_for_match" do
    it "returns true if the client correctly counts the words in the string" do
      captcha = Captcha.new(long_text)
      captcha.get_excluded_array
      captcha.get_included_array
      captcha.get_word_frequency
      expect(captcha.check_for_match(answer_hash)).to eq(true)
    end
  end
     
end