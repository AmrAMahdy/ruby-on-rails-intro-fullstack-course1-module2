#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  attr_reader :highest_wf_count # a number with maximum number of occurrences for a single word (calculated)
  attr_reader :highest_wf_words # an array of words with the maximum number of occurrences (calculated)
  attr_reader :content          # the string analyzed (provided)
  attr_reader :line_number      # the line number analyzed (provided)

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize(line, line_number)
    @content = line
    @line_number = line_number
    calculate_word_frequency
  end
  #* calculate_word_frequency() - calculates result
  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency
    wf = Hash.new(0)
    @content.split.each do |word|
      wf[word.downcase] += 1
    end
    @highest_wf_count = wf.sort_by { |k, v| v } .to_a.last[1]
    
    @highest_wf_words = []
    wf.each_pair { |k,v| @highest_wf_words << k if v == @highest_wf_count }
  end 

end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines


  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  def initialize
    @analyzers = []
  end
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file
  def analyze_file
    File.foreach('test.txt') do |line|
      @analyzers << LineAnalyzer.new(line,@analyzers.length)
    end
  end
  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency
    @analyzers.sort_by! {|a| a.highest_wf_count}.reverse!
    @highest_count_across_lines = @analyzers.first.highest_wf_count
    
    @highest_count_words_across_lines = @analyzers.select {|a| a.highest_wf_count == @highest_count_across_lines}
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |line|
      puts "#{line.highest_wf_words.inspect} (appears in line ##{line.line_number})"
    end
  end
end
