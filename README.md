# sentiwordnet_ruby

Simple SentiWordNet 3.0 based tool for sentimental analysis. It is inspired from https://github.com/7compass/sentimental

## How it works

Sentences are tokenized, tokens are assigned a numerical score provided by SentiWordNet 3.0.
The total score is then used to determine the overall sentiment.

For example, If a sentence has a score of 0, it is deemed "neutral".


- Very positive scores are > 0.75
- Positive scores are > 0.25 &  <= 0.75
- Weak positive scores are > 0 & score <= 0.25
- Weak negative scores are  < 0 & >= -0.25
- Negative scores are < -0.25 &&  >= -0.75
- Very negative scores are < -0.75


## Usage

```ruby

# Load the default sentiment dictionaries
SentiWordNet.load_defaults

# And/or load your own SentiWordNet dictionaries
# Note:- Please remove the lines starting with '#' before loading a disctionary

SentiWordNet.load_senti_file('path/to/your/file.txt')



# Create an instance for usage:
analyzer = SentiWordNet.new
analyzer.get_sentiment "I love sentiwordnet"
#=> "very_positive"

analyzer.get_sentiment 'I like sentiwordnet'
#=> "positive"



# Get the numerical score of a string:
analyzer.get_score 'I love sentiwordnet'
#=> 0.9841496598639456

```

## Installation 

    gem install sentiwordnet_ruby

## Credits

SentiWordNet lexical resource for opinion mining
http://sentiwordnet.isti.cnr.it/

Gem functionality inspired from Seventh Compass, Inc.'s gem:
https://github.com/7compass/sentimental
