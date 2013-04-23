class SentiWordNet

  @@sentihash = {}
  @@threshold = 0.0


  def get_score(string)
    sentiment_total = 0.0

    #tokenize the string, also throw away some punctuation
    tokens = tokenize(string)

    tokens.each do |token|

        if @@sentihash[token+"#n"]
          sentiment_total += @@sentihash[token+"#n"]
        end

        if @@sentihash[token+"#a"]
          sentiment_total += @@sentihash[token+"#a"]
         end

        if @@sentihash[token+"#r"]
          sentiment_total += @@sentihash[token+"#r"]
        end

        if @@sentihash[token+"#v"]
          sentiment_total += @@sentihash[token+"#v"]
        end
    end

    sentiment_total
  end

  def get_sentiment(string)
    score = get_score(string)

    if (score > 0.75)
      return "very_positive"
    elsif (score > 0.25 && score <= 0.75)
      return "positive"
    elsif (score > 0 && score <= 0.25)
      return "weak_positive"
    elsif (score == 0)
      return "neutral"
    elsif (score < 0 && score >= -0.25)
      return "weak_negative"
    elsif (score < -0.25 && score >= -0.75)
      return "negative"
    elsif (score < -0.75)
      return "very_negative"
    end
  end

  def tokenize string
    fold_case = false
    string.split(/\s+/).map do |token|
      stripped = token.gsub(/[^a-zA-Z0-9\']+/, '')
      fold_case ? stripped.downcase : stripped
    end
  end


  def self.load_defaults
    load_senti_file(File.dirname(__FILE__) + '/SentiWordNet_3.0.0.txt')
  end

  def self.load_senti_file(filename)
    word_temp = Hash.new

    File.readlines(filename).each do |line|
      data = line.split("\t")
      score = data[2].to_f - data[3].to_f
      words = data[4].split(" ")
      words.each do |w|
        w_n = w.split("#")
        w_n[0] += "#"+data[0]
        index = w_n[1].to_i - 1
        if word_temp.has_key?(w_n[0])
          v = word_temp[w_n[0]]
          if (index > v.size)
            ((v.size)..(index - 1)).each do |i|
              v << 0.0
            end
          end
          v[index] = score
          word_temp[w_n[0]] = v
        else
          v = []
          (0..(index - 1)).each do |i|
            v << 0.0
          end
          v[index] = score
          word_temp[w_n[0]] = v
        end
      end
    end

    word_temp.keys.each do |k|
      word = k
      v = word_temp[k]
      score = 0.0
      sum = 0.0
      (0..(v.size - 1)).each do |i|
        score += (1.0/(i+1).to_f)* v[i]
      end
      (1..(v.size)).each do |i|
        sum += 1.to_f/i.to_f
      end
      score /= sum
      @@sentihash[word] = score
    end
    end
end

#SentiWordNet.load_senti_file('SentiWordNet_3.0.0.txt')

