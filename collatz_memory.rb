require 'benchmark'
@memory = {1 => 1}

# Finds the length of a Collatz Sequence without building it
def collatz_length(number)
  raise 'Loop detected!' if @start == number && number != 1

  return @memory[number] if @memory.key?(number)

  @memory[number] = collatz_length(next_collatz_number(number)) + 1
end

def next_collatz_number(number)
  return 1 if number == 1
  number.even? ? number / 2 : number * 3 + 1
end

# Builds a numbers Collatz Sequence and returns it
def collatz_sequence(number)
  sequence = []

  loop do
    sequence.push(number)
    number.even? ? number = (number / 2) : number = (3 * number) + 1
    break if sequence[-1] == 1
  end

  sequence
end

# Keeps track of the longest Collatz Sequence for all given integer inputs
longest = { length: 1, digit: 1, sequence: 1 }
n = 1

time = Benchmark.measure {
  while n <= 1_000_000
    @start = n
    second_element = next_collatz_number(n)
    collatz = collatz_length(second_element) + 1

    if collatz > longest[:length]
      longest[:length] = collatz
      longest[:digit] = n
    end

    n += 1
  end

  longest[:sequence] = collatz_sequence(longest[:digit])

  puts "\nThe longest Collatz Sequence for an integer input between 1 and 1,000,000 
  is the number #{longest[:digit]} with a length of #{longest[:length]}!"
  
  puts "\n----------"
  
  puts "\nThe sequence for #{longest[:digit]} is: \n\n #{longest[:sequence]}"
  
  puts "\n----------\n"
}

puts time.real
