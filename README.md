## Alien Captcha

### Description
This web service verifies that a client can count words. It supplies clients with a "test" and allows the client to submit an answer. If the client and the service were people, their conversation might go something like this:

> **Client**: Service, can you give me some words to count?
> 
> **Service**: Sure. Please count the frequency of the words in "The quick brown fox jumped over the lazy dog" but please ignore the words "the" and "dog".
> 
> **Client**: Ok, the original text was "The quick brown fox jumped over the lazy dog" and in this text, ignoring the words  "the" and "dog", "quick" appeared once, "brown" appeared once, "fox" appeared once, "jumped" appeared once, "over" appeared once, "lazy" appeared once, and "the" appeared twice.
> 
> **Service**: Sorry, that's wrong. Nice try space troll.
> 
> **Client**: Oops, what I meant was the original text was "The quick brown fox jumped over the lazy dog" and in this text, ignoring the words  "the" and "dog", "quick" appeared once, "brown" appeared once, "fox" appeared once, "jumped" appeared once, "over" appeared once, and "lazy" appeared once.
> 
> **Service**: Looks great.

### Installation
+ Please use Ruby 2.1.2
+ Make sure you have Bundler installed. If not, run `gem install bundler`
+ Run `bundle install`
+ Start app by running `./run`

### Decisions
+ I designed the server to count distinct words in the source text regardless of language. This allows for source text to be in languages that use characters outside of the English alphabet. It is also case insensitive when counting words.

+ For source texts with less than 4 unique words, I decided to determine which words get excluded by selecting the first word. For text with 4 or more unique words, I grabbed the first three words to be excluded from the word frequency count.

+ I assumed the client will make a post request in the format below. (If there is no word to be excluded (in the case of source texts with one unique word), I expect the client to include an array with an empty string as the value to the "exclude" key.)
```ruby
{
	"source_text" => "The quick brown fox jumped over the lazy dog.",
	"exclude" => [
		"the", 
		"quick", 
		"brown"
	],
	"words" => {
		"fox"=> 1, 
		"jumped"=> 1, 
		"lazy"=> 1, 
		"dog"=> 1, 
		"over"=> 1
	}
}
```
+ I have made the service stateless, but it is susceptibile to cheating at the moment. My next step is to encrypt the source text and require the client to include it as an additional key in the POST request. The server will then decrypt this key and match it to the unencrypted source text passed by the client. If they do not match, then the server returns 400.

+ Initially, I built out the service to display a form to the client, but I decided to remove it to build a simpler REST API. As such, I am assuming the aliens know how to consume web services because, well, they're aliens so they're assumably pretty tech-savvy.
